package controller.response;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import message.WooriLoanResponse;
import service.AccountInfoService;
import service.AccountInfoServiceImpl;
import service.LoanInfoService;
import service.LoanInfoServiceImpl;
import service.MemberService;
import service.MemberServiceImpl;
import vo.AccountInfoDTO;
import vo.LoanDTO;
import vo.LoanExisting;
import vo.OtherAccountDTO;
@WebServlet({"/loan-response", "/loan-existing", "/loan-records", "/overdue", "/other-accounts", "/woori-loan-judge"})
public class LoanInfoResponseController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Gson gson = new Gson();
    private final LoanInfoService loanInfoService = new LoanInfoServiceImpl();
    
    public LoanInfoResponseController(){
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        String comPath = request.getContextPath();
        String command = uri.substring(comPath.length());
        if (command.equals("/loan-response")) {
            // Personal number
            String personalIdNumber = request.getParameter("personalIdNumber");
            String[] banksArray = request.getParameterValues("banks");
            List<String> banks = Arrays.asList(banksArray != null ? banksArray : new String[0]);

            List<LoanDTO> loanInfos = loanInfoService.findbyLoanData(personalIdNumber, banks);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(loanInfos));;
        } if (command.equals("/loan-existing")) {
            String loanRecordId = request.getParameter("loanRecordId");
            String bank = request.getParameter("bank");
            
            LoanExisting loanExisting = loanInfoService.fetchLoanExistingFromDatabase(loanRecordId, bank);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            if (loanExisting != null) {
                // Convert loanExisting object to JSON (using Gson or other library)
                String jsonResponse = new Gson().toJson(loanExisting);
                out.print(jsonResponse);
            } else {
                // Handle not found case
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{ \"error\": \"LoanExisting not found\" }");
            }
            
            out.flush();
        } if (command.equals("/loan-records")) {
            String personalIdStr = request.getParameter("personalId");
            if (personalIdStr == null || personalIdStr.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            Long loanBalance = loanInfoService.getLoanBalanceByPersonalId(personalIdStr);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"personalId\":" + personalIdStr + ",\"loanBalance\":" + loanBalance + "}");
            out.flush();
            
            
        } if(command.equals("/other-accounts")) {
            String personalId = request.getParameter("personalId");
            List<OtherAccountDTO> accounts = loanInfoService.findByAccounts(personalId);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(accounts));;
            
            
        }
        
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String uri = request.getRequestURI();
        String comPath = request.getContextPath();
        String command = uri.substring(comPath.length());
        if (command.equals("/overdue")) {
            // 파라미터 값을 가져옵니다.
            String fees = request.getParameter("fee");
            String repaymentAccount = request.getParameter("repaymentAccount");
            String finance = request.getParameter("finance");
            // 파라미터 값을 확인하기 위해 콘솔에 출력 (필요한 로직으로 대체 가능)
            int fee = Integer.parseInt(fees);
    
            loanInfoService.updateOverdueByFeeAndAccount(fee, repaymentAccount,finance);
            
            loanInfoService.updateTransactionByFeeAndAccount(fee,repaymentAccount, finance);
            // 응답
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
            response.getWriter().write("Received PUT request with fee: " + fee + ", repaymentAccount: " + repaymentAccount + ", finance : " + finance);
        }
    }
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String uri = request.getRequestURI();
        String comPath = request.getContextPath();
        String command = uri.substring(comPath.length());
        if (command.equals("/woori-loan-judge")) {
            String personalIdStr = request.getParameter("personalId");
            Long personalId = Long.parseLong(personalIdStr);

            // Service layer 호출
            WooriLoanResponse wooriLoanResponse = loanInfoService.getLoanDetails(personalId);

            // JSON으로 변환하여 응답
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"userId\":\"" + wooriLoanResponse.getUserId() + 
                      "\", \"loanRecordIds\":" + wooriLoanResponse.getLoanRecordIds().toString() + "}");
            out.flush();
        }
    }
    
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String uri = request.getRequestURI();
        String comPath = request.getContextPath();
        String command = uri.substring(comPath.length());
        if (command.equals("/loan-existing")) {
            String loanRecordIdStr = request.getParameter("loanRecordId");
            String finance = request.getParameter("finance");
            long loanRecordId = Long.parseLong(loanRecordIdStr);
            loanInfoService.deleteByRecordIdAndFinance(loanRecordId, finance);
            System.out.println("Loan Record ID: " + loanRecordId);
            System.out.println("Finance: " + finance);

            // 응답 설정
            response.setContentType("text/plain");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().println("Data received and processed");;
        }
    }

}
