package LabPack;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Stack;

/**
 * Created by Another Denis on 24.10.2017.
 */
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter outputWriter = resp.getWriter();
        String R = req.getParameter("varR");
        String X = req.getParameter("varX");
        String Y = req.getParameter("varY");
        boolean xValid = false;
        if (isNumeric(X)) {
            for (double i = -2; i <= 2.0; i += 0.5) {
                xValid = xValid || (Double.parseDouble(X) == i);
            }
        }
        if (xValid && isNumeric(R) && Double.parseDouble(R) >= 2 && Double.parseDouble(R) <= 5 && isNumeric(Y) && Double.parseDouble(Y) >= -5 && Double.parseDouble(Y) <= 5) {
            resp.setContentType("text/html;charset=utf-8");
            double x = Double.parseDouble(X);
            double y = Double.parseDouble(Y);
            double r = Double.parseDouble(R);
            Stack buffStack = new Stack();
            ServletContext a = getServletContext();
            if (a.getAttribute("Table") == null) {
                a.setAttribute("Table", new Stack());
            }
            Stack tableStack = (Stack) a.getAttribute("Table");
            boolean res = ((x < 0 && y >= 0 && (x * x + y * y) < r * r / 4) || (x >= 0 && y >= 0 && x <= r && y <= (r / 2)) || (x >= 0 && y < 0 && y > (x - r / 2)));
            tableStack.push(new TableRow(x, y, r, res));
            buffStack=(Stack) tableStack.clone();
            a.setAttribute("Table",buffStack);
            resp.setContentType("text/html;charset=UTF-8");
            outputWriter.println("<html>" +
                    "<link rel=\"stylesheet\" type=\"text/css\" href=\"Styles/resStyle.css\" media=\"screen\" />" +
                    "<head>\n" +
                    "\t<meta charset=\"utf-8\">\n" +
                    "<title>Result</title>\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "\t<div class = \"table\" >\n" +
                    "\t\t<p>\n" +
                    "\t\t\t<table class= \"t\" border = \"1\" align=\"center\" >\n" +
                    "\t\t\t\t<tr>\n" +
                    "\t\t\t\t\t<th>\n" +
                    "\t\t\t\t\t\tParam X\n" +
                    "\t\t\t\t\t</th>\n" +
                    "\t\t\t\t\t<th>\n" +
                    "\t\t\t\t\t\tParam Y\n" +
                    "\t\t\t\t\t</th>\n" +
                    "\t\t\t\t\t<th>\n" +
                    "\t\t\t\t\t\tParam R\n" +
                    "\t\t\t\t\t</th>\n" +
                    "\t\t\t\t\t<th>\n" +
                    "\t\t\t\t\t\tResult\n" +
                    "\t\t\t\t\t</th>\n" +
                    "\t\t\t\t</tr>");
            while (!tableStack.empty()) {
                TableRow currRow = (TableRow) tableStack.pop();
                outputWriter.println("\t\t\t\t<tr>\n" +
                        "\t\t\t\t\t<th>\n" +
                        "\t\t\t\t\t\t" + currRow.getX() + "\n" +
                        "\t\t\t\t\t</th>\n" +
                        "\t\t\t\t\t<th>\n" +
                        "\t\t\t\t\t\t" + currRow.getY() + "\n" +
                        "\t\t\t\t\t</th>\n" +
                        "\t\t\t\t\t<th>\n" +
                        "\t\t\t\t\t\t" + currRow.getR() + "\n" +
                        "\t\t\t\t\t</th>\n" +
                        "\t\t\t\t\t<th>\n" +
                        "\t\t\t\t\t\t" + currRow.isRes() + "\n" +
                        "\t\t\t\t\t</th>\n" +
                        "\t\t\t\t</tr>");
            }
            outputWriter.println("\t\t\t</table>\n" +
                    "\t\t</p>\n" +
                    "\t</div>\n" +
                    "</body>\n" +
                    "<a href=\"mainPage.jsp\">link text</a>\n" +
                    "</html>");

            outputWriter.println("");
        }else{
            outputWriter.println("error, wrong input format");
        }
    }
    public static boolean isNumeric(String str) {
        return str != null && str.matches("-?\\d+(\\.\\d+)?");
    }
}
