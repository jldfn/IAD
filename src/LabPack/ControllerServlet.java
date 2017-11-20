package LabPack;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Another Denis on 23.10.2017.
 */
public class ControllerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String R = req.getParameter("varR");
        String X = req.getParameter("varX");
        String Y = req.getParameter("varY");
        if (R != null || X != null || Y != null) {
            resp.sendRedirect("AreaCheckServlet?varR=" + R + "&varX=" + X + "&varY=" + Y);
        } else {
            resp.sendRedirect("mainPage.jsp");
        }
    }

}
