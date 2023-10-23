package controller.response;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.HometaxService;
import service.HometaxServiceImpl;
import service.KCBInfoService;
import service.KCBInfoServiceImpl;
import vo.HomtaxCreditInfoDTO;
import vo.HomtaxPersonalMemberDTO;
import vo.KcbMemberDTO;

@WebServlet({"/homtax","/hometax-info"})
public class HometaxResponseController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Gson gson = new Gson();
    private final HometaxService hometaxService = new HometaxServiceImpl();

    public HometaxResponseController(){
        super();
    }
    
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String uri = request.getRequestURI();
            String comPath = request.getContextPath();
            String command = uri.substring(comPath.length());
            if(command.equals("/homtax")){
                String personalIdParam = request.getParameter("personalId");
                long personalId = Long.parseLong(personalIdParam);
                
                HomtaxPersonalMemberDTO member = hometaxService.getMemberByPersonalId(personalId);
                
                List<HomtaxCreditInfoDTO> creditInfoList = hometaxService.getCreditInfoByMemberId(member.getId());
                
                
                response.setContentType("application/json; charset=utf-8");
                PrintWriter out = response.getWriter();
                String jsonResponse = new Gson().toJson(creditInfoList); // 여기서 Gson은 Google의 json 변환 라이브러리입니다.
                out.print(jsonResponse);
                out.flush();
                out.close();
                
                
            } if(command.equals("/hometax-info")){
                String id = request.getParameter("id");
                String password = request.getParameter("password");
 
                List<HomtaxCreditInfoDTO> creditInfoList = hometaxService.getCreditInfoByMemberIdAndPassword(id, password);
                
                
                response.setContentType("application/json; charset=utf-8");
                PrintWriter out = response.getWriter();
                String jsonResponse = new Gson().toJson(creditInfoList); // 여기서 Gson은 Google의 json 변환 라이브러리입니다.
                out.print(jsonResponse);
                out.flush();
                out.close();
                
            }
        }
            

}
