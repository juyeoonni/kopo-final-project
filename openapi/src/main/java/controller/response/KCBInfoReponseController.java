package controller.response;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.KCBInfoService;
import service.KCBInfoServiceImpl;
import vo.AllCreditDTO;
import vo.AllCreditInfoDTO;
import vo.KcbAssetDTO;
import vo.KcbCreditInfoDTO;
import vo.KcbMemberDTO;


@WebServlet({"/kcb-credit"})
public class KCBInfoReponseController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Gson gson = new Gson();
    private final KCBInfoService kcbInfoService = new KCBInfoServiceImpl();

    public KCBInfoReponseController(){
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        String uri = request.getRequestURI();
        String comPath = request.getContextPath();
        String command = uri.substring(comPath.length());
        if(command.equals("/kcb-credit")){
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String str;
            while ((str = reader.readLine()) != null) {
                sb.append(str);
            }
            String jsonString = sb.toString();

            Map<String, String> map = gson.fromJson(jsonString, Map.class);
            String username = map.get("username");
            String password = map.get("password");
            
            if(username==null || password == null) {
                response.getWriter().write("username, password null");
            }
            
            List<AllCreditInfoDTO> creditList = kcbInfoService.findMemberIdByCreditScore(username, password);
            
//            List<KcbAssetDTO> assetList = kcbInfoService.findMemberIdByAsset(username,password);
            
            // 여기에 로직을 추가하세요
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("result", "success");
            resultMap.put("creditList", creditList);
//            resultMap.put("assetList", assetList);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(resultMap));
        }
        
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        String comPath = request.getContextPath();
        String command = uri.substring(comPath.length());
        if(command.equals("/kcb-credit")){
            
            String personalIdParam = request.getParameter("personalId");
            long personalId = Long.parseLong(personalIdParam);
            
            AllCreditDTO member = kcbInfoService.getMemberByPersonalId(personalId);
            
        
        
            if (member != null) {
      
                List<AllCreditInfoDTO> creditInfos = kcbInfoService.getCreditInfoByMemberId(member.getId());
//                List<KcbAssetDTO> assetsInfos = kcbInfoService.getAssetsInfoByMemberId(member.getMemberId());
    
                // 응답 JSON 만들기
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("creditInfos", creditInfos); // ObjectMapper를 사용하여 객체를 JSON으로 변환하세요.
//                jsonResponse.put("assetsInfos", assetsInfos);
    
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Member not found.");
            }
        }   
    }
}