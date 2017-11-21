<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="LabPack.TableRow" %>
<%@ page import ="java.util.Stack" %>
<html>
<script type="text/javascript">
    setInterval(Rchange, 1500);
    var Height=600;
    var Width=600;
    var oldR=2.0;
    var rScale=50;
    function Rchange() {
        var newR = parseFloat(document.getElementById("varR").value);
        var newScale = parseInt(document.getElementById("rScale").value);
        if ((oldR !== newR || rScale !== newScale) && newR >= 0 && rScale >= 25) {
            oldR = newR;
            rScale = newScale;
            redraw(newR);
        }

    }

    function redraw(r){
        var example = document.getElementById("graph"),
            ctx = example.getContext('2d');
        graph.height = Height;
        graph.width  = Width;
        ctx.fillStyle="white";
        ctx.fillRect(0,0,Width,Height);
        for(var i=rScale;i<Width/2;i+=rScale){
            ctx.beginPath();
            ctx.moveTo(parseInt(Width/2)+i,0);
            ctx.lineTo(parseInt(Width/2)+i,Height);
            ctx.stroke();
            ctx.closePath();
            ctx.beginPath();
            ctx.moveTo(0,parseInt(Height/2)+i);
            ctx.lineTo(Width,parseInt(Height/2)+i);
            ctx.stroke();
            ctx.closePath();
            ctx.beginPath();
            ctx.moveTo(0,parseInt(Height/2)-i);
            ctx.lineTo(Width,parseInt(Height/2)-i);
            ctx.stroke();
            ctx.closePath();
            ctx.beginPath();
            ctx.moveTo(parseInt(Width/2)-i,0);
            ctx.lineTo(parseInt(Width/2)-i,Height);
            ctx.stroke();
            ctx.closePath();
        }
        ctx.beginPath();
        ctx.lineWidth=3;
        ctx.moveTo(parseInt(graph.width/2),0);
        ctx.lineTo(parseInt(graph.width/2),graph.height);
        ctx.moveTo(0,parseInt(graph.height/2));
        ctx.lineTo(graph.width,parseInt(graph.height/2));
        ctx.stroke();
        ctx.strokeStyle="blue";
        ctx.strokeRect(parseInt(graph.width/2),parseInt(graph.height/2-r*rScale/2),r*rScale,r*rScale/2);
        ctx.beginPath();
        ctx.moveTo(parseInt(graph.width/2),parseInt(graph.height/2));
        ctx.lineTo(parseInt(graph.width/2+r*rScale/2),parseInt(graph.height/2));
        ctx.lineTo(parseInt(graph.width/2),parseInt(graph.height/2+r*rScale/2));
        ctx.closePath();
        ctx.stroke();
        ctx.beginPath();
        ctx.arc(parseInt(graph.width/2),parseInt(graph.height/2),r*rScale/2,Math.PI,Math.PI*3/2,false);
        ctx.stroke();
        ctx.closePath();
        ctx.fillStyle="blue";
        <%
        if(application.getAttribute("Table")!=null){
            Stack tableStack= (Stack)application.getAttribute("Table");
            application.setAttribute("Table",tableStack.clone());
            while(!tableStack.empty()){
                LabPack.TableRow currRow= (LabPack.TableRow) tableStack.pop();
                out.println("ctx.beginPath();");
                out.println("ctx.arc(Width/2+"+currRow.getX()+"*rScale,Height/2-("+currRow.getY()+"*rScale),5,0,Math.PI*2);");
                out.println("ctx.fill();");
                out.println("ctx.closePath();");
            }
        }else{
            application.setAttribute("Table",new Stack());
        }
        %>
    }
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<head>
    <meta http-equiv="Content-Type"/>
    <link rel="stylesheet" type="text/css" href="Styles/mainStyle.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="Styles/resStyle.css" media="screen" />
    <meta charset="utf-8" />
    <title>
        VeryGOOD
    </title>
</head>
<body>
<div class="container">
    <div class = "header">
        Гришин Денис Олегович, Никутьев Дмитрий Евгеньевич <br>
        Группа P3211. Вариант 303.
    </div>
    <div class = "form">
        <form action="Controller" method="post" id="labForm">
            <p>
                Область, в которую должна попасть точка определяется переменной R.
                Для задания положения точки изменяйте параметры X и Y.
                <br>

                <label for="varX">
                    Значение X:
                </label>
                <br/>
                <input type="checkbox" name="varX" value="-2.0" id="varX"/>
                -2
                <br/>
                <input type="checkbox" name="varX" value="-1.5" />
                -1.5
                <br/>
                <input type="checkbox" name="varX" value="-1.0" />
                -1.0
                <br/>
                <input type="checkbox" name="varX" value="-0.5" />
                -0.5
                <br/>
                <input type="checkbox" name="varX" value="0" checked="" />
                0
                <br/>
                <input type="checkbox" name="varX" value="0.5" />
                0.5
                <br/>
                <input type="checkbox" name="varX" value="1.0" />
                1
                <br/>
                <input type="checkbox" name="varX" value="1.5" />
                1.5
                <br/>
                <input type="checkbox" name="varX" value="2.0" />
                2
                <br />

                <label for="varY">
                    Значение Y:
                </label>
                <input type="text" name="varY" value="0" id="varY"/>
                <br />

                <label for="varR">
                    Значение R:
                </label>
                <br />

                <input type="text" name="varR" id="varR" value="2">
                <br />

                <input type="submit" value="Send" onclick=" return Check();" >
                <script>
                    function Check(){
                        var s="";
                        var flag=true;
                        if ((parseFloat(document.getElementById('varY').value) > parseFloat('5'))||(parseFloat(document.getElementById('varY').value) < parseFloat('-5'))||(document.getElementById('varY').value == '')|| isNaN(document.getElementById('varY').value))
                        {
                            s="Y должен попадать в диапазон от -5 до 5 включительно. ";
                            flag=false;
                        }
                        if ((parseFloat(document.getElementById('varR').value) > parseFloat('5'))||(parseFloat(document.getElementById('varR').value) < parseFloat('2'))||(document.getElementById('varR').value == '')|| isNaN(document.getElementById('varR').value)){
                            s+="R должен попадать в диапазон от 2 до 5 включительно";
                            flag=false;
                        }
                        if(!flag){
                            alert(s);
                        }
                        return flag;
                    }
                </script>
                <input type="reset"  value="Clear">
                <br>
                <?php
					echo $_COOKIE['hacker'];
					?>
            </p>
        </form>
        </br>
        <label for="rScale">
            Масштаб
        </label>
        <input type="text" name="rScale" value="50" id="rScale"/>
    </div>
    <div class= "picture" >
        <canvas id='graph' onclick="passLoc(event);"></canvas>
        <script>
            function passLoc(event) {
                if(!isNaN(document.getElementById("varR").value)&& parseFloat(document.getElementById("varR").value)>=2 && parseFloat(document.getElementById("varR").value)<=5){
                    var x = event.offsetX;
                    var y = event.offsetY;
                    x=(x-Width/2)/rScale;
                    var X=document.getElementsByName("varX");

                    for( i=1; i<X.length; i++){
                        if (X[i].checked) X[i].checked=false;
                    }

                    X[0].checked = true;

                    alert(!X[0].checked);

                    for( i=1; i<X.length; i++){
                        // alert("infor!");
                        if (Math.abs(parseFloat(X[i].value)-x) < Math.abs(parseFloat(X[i-1].value) - x)){
                            X[i-1].checked = false;
                            X[i].checked = true;
                        } else {
                            break;
                        }
                    }

                    alert("ye");
                    // X[i].value = ((x-Width/2)/rScale);
                    document.getElementById("varY").value = (-(y-Height/2)/rScale);
                    document.forms["labForm"].submit();
                }else{
                    alert("R может находиться в промежутке от 2 до 5 включительно");
                }
            }
            redraw(2);
        </script>
    </div>
    <% Stack tableStack=(Stack) application.getAttribute("Table");
        application.setAttribute("Table",tableStack.clone());
        out.println("\t<div class = \"table\" >\n" +
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
            out.println("\t\t\t\t<tr>\n" +
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
        out.println("\t\t\t</table>");
    %>
    <div class="clear">
    </div>
</div>
<div class = "podval">
    <div class = "gif1">
        <img src="https://se.ifmo.ru/~s225093/1.gif" alt="Гифки кончились :(">
    </div>
    <div class = "button">
        <button class="new" onclick="location.href = 'http://yummyanime.com/random'">
            Портал в 2D
        </button>
    </div>
    <div class = "gif2">
        <img src="https://se.ifmo.ru/~s225093/2.gif" alt="Гифки кончились :(">
    </div>
</div>
</body>


<script type="text/javascript">
    var $unique = $('input[type="checkbox"]');
    $unique.click(function() {
        $unique.filter(':checked').not(this).removeAttr('checked');
    });
</script>
</html>
