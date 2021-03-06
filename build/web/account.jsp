<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="oracle.net.aso.p"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.eshopper.connection.Database" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Account |  e-SHOPPER</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    </head><!--/head-->




    <body>
        <%
            //out.print(request.getParameter("fromlog"));
            try {

                Database db = new Database();
                db.connect();
                Statement stmt = db.connection.createStatement();
                Statement stmt5 = db.connection.createStatement();
                String qry5 = "select count(*) from cart where email like '" + session.getAttribute("cartid") + "'";
                ResultSet rs5 = stmt5.executeQuery(qry5);
                rs5.next();
                if (session.getAttribute("userid") == null) {
                    response.sendRedirect("index.jsp");
                }
                
                Statement stmt6 = db.connection.createStatement();
                ResultSet rs6=stmt6.executeQuery("select max(email)+1 as mx from cart");
                rs6.next();
                
                //out.print(rs6.getString("mx"));
                if(session.getAttribute("cartid")==null||(!(session.getAttribute("cartid").toString().compareTo("99999999")<0&&session.getAttribute("cartid").toString().compareTo("0")>0)))
                {
                    session.setAttribute("cartid",rs6.getString("mx"));
                }

                Statement stmt2 = db.connection.createStatement();
                String qry2 = "select * from customer where email like '" + session.getAttribute("userid") + "'";
                ResultSet rs2 = stmt2.executeQuery(qry2);
                rs2.next();

                int flag = 0;

                if (request.getParameter("changereq") != null) {
                    if (rs2.getString("password_").equals(request.getParameter("pwd"))) {

                        String qry = new String();
                        if (request.getParameter("newpwd").length() > 0) {
                            qry = "update customer set customer_name='" + request.getParameter("fullname") + "',customer_add='" + request.getParameter("address") + "',customer_city='" + request.getParameter("city") + "',password_='" + request.getParameter("newpwd") + "' where email like '" + session.getAttribute("userid") + "'";
                        } else {
                            qry = "update customer set customer_name='" + request.getParameter("fullname") + "',customer_add='" + request.getParameter("address") + "',customer_city='" + request.getParameter("city") + "'" + " where email like '" + session.getAttribute("userid") + "'";
                        }

                        //out.print(qry);
                        stmt.executeQuery(qry);
                        flag = 1;

                    } else {
                        if(rs2.getString("password_").length()>0&&request.getParameter("pwd").length()==0)
                            flag=3;
                        else
                        flag = 2;

                    }
                }

                Statement stmt7 = db.connection.createStatement();
                String qry7 = "select count(*) from cart where email like '" + session.getAttribute("cartid") + "'";
                ResultSet rs7 = stmt7.executeQuery(qry7);
                rs7.next();

                rs2 = stmt2.executeQuery(qry2);
                rs2.next();
                String CompanyPic="images/u"+rs2.getString("customer_id")+".jpg";
               // out.println("OOOO"+CompanyPic+"OOOOO");
        %>
        <header id="header"><!--header-->
            <div class="header_top"><!--header_top-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 ">
                            <div class="contactinfo">
                                <ul class="nav nav-pills">
                                    <li><a href="contact-us.jsp"><i class="fa fa-phone"></i> +8801738896778 </a></li>
                                    <li><a href="contact-us.jsp"><i class="fa fa-envelope"></i> eshopperinfo@gmail.com</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="social-icons pull-right">
                                <ul class="nav navbar-nav">
                                    <li><a href="http://facebook.com"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="http://twitter.com"><i class="fa fa-twitter"></i></a></li>
                                    <li><a href="http://linkedin.com"><i class="fa fa-linkedin"></i></a></li>
                                    <li><a href="http://drrible.com"><i class="fa fa-dribbble"></i></a></li>
                                    <li><a href="http://plus.google.com"><i class="fa fa-google-plus"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header_top-->

            <div class="header-middle"><!--header-middle-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <a href="index.jsp"><img src="images/home/logo.png" alt="" /></a>
                            </div>

                        </div>

                        <div class="col-sm-8">
                            <div class="shop-menu pull-right">
                                <ul class="nav navbar-nav">
                                    <%//String temp = session.getAttribute("userid").toString();
                                            if (session.getAttribute("userid") != null && (session.getAttribute("userid").toString().length()>4)) {%>
                                <li><a href="stats.jsp"><i class="fa fa-file"></i>Stats</a></li>
                                <li><a href="update.jsp"><i class="fa fa-pencil-square-o"></i> Upadate</a></li>
                                <%}%>
                                <li><a href="wishlist.jsp"><i class="fa fa-star"></i> Wishlist</a></li>
                                    <%//String temp = session.getAttribute("userid").toString();
                                        if (session.getAttribute("userid") != null && (!session.getAttribute("userid").toString().endsWith("0"))) {%>

                                <li><a href="cart.jsp"><i class="fa fa-shopping-cart"></i> Cart(<%=rs5.getInt("count(*)")%>)</a></li>
                                <li><a href="account.jsp"><%=session.getAttribute("userid")%></a></li>
                                <li><a href="login.jsp"><i class="fa fa-unlock"></i> Logout</a></li>
                                    <%} else {%>
                                <li><a href="login.jsp"><i class="fa fa-shopping-cart"></i> Cart(<%=rs5.getInt("count(*)")%>)</a></li>
                                <li><a href="login.jsp"><i class="fa fa-crosshairs"></i> Register</a></li>
                                <li><a href="login.jsp"><i class="fa fa-lock"></i> Login</a></li>
                                    <%}%>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header-middle-->
            <div class="header-bottom"><!--header-bottom-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-9">

                            <div class="mainmenu pull-left">
                                <ul class="nav navbar-nav collapse navbar-collapse">
                                    <li><a href="index.jsp" class="active">Home</a></li> 
                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div><!--/header-bottom-->
        </header>
         
                        
        <!--/header-->
        <section id="form"><!--form-->
            <div class="container">
                
                        
                
                
                <div class="col-sm-4">
                    <div class="signup-form"><!--sign up form-->
                        
                        
                        
                        <h1>Profile</h1>
                        
                                               
                                <!-- upload image section -->        
                <div style="margin-left: 280px;">
                                    <%
         //out.print((request.getRequestURL()).toString());
                                        if (request.getParameter("is_image_selected") == null || !request.getParameter("is_image_selected").startsWith("yes")) {
                                        //request.setAttribute("is_image_selected","yes");
                                    %>
                                    <form method="POST" action="account.jsp?is_image_selected=yes" enctype="multipart/form-data" style="width: 110px; padding-top: 5px; height: 65px;">
                                        <%
                                            String saveFile = new String();
                                            String saveFile2 = new String();
                                            String contentType = request.getContentType();
                                            if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                                                DataInputStream in = new DataInputStream(request.getInputStream());

                                                int formDataLength = request.getContentLength();
                                                byte dataBytes[] = new byte[formDataLength];
                                                int byteRead = 0;
                                                int totalBytesRead = 0;

                                                while (totalBytesRead < formDataLength) {
                                                    byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                                                    totalBytesRead += byteRead;
                                                }
                                                String file = new String(dataBytes);

                                                saveFile = file.substring(file.indexOf("filename=\"") + 10);
                                                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                                                saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));

                                                int lastIndex = contentType.lastIndexOf("=");

                                                String boundary = contentType.substring(lastIndex + 1, contentType.length());

                                                int pos;

                                                pos = file.indexOf("filename=\"");
                                                pos = file.indexOf("\n", pos) + 1;
                                                pos = file.indexOf("\n", pos) + 1;
                                                pos = file.indexOf("\n", pos) + 1;

                                                int boundaryLocation = file.indexOf(boundary, pos) - 4;

                                                int startPos = ((file.substring(0, pos)).getBytes()).length;
                                                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

                                                Statement stmt9 = db.connection.createStatement();
                                                ResultSet rs9;
                                                rs9 = stmt9.executeQuery("select max(product_code)+1 as mx from product");
                                                rs9.next();

                                                saveFile = "C:/Users/User/Desktop/e-SHOPPER/web/images/u" + rs2.getString("customer_id") + ".jpg";
                                                saveFile2 = "C:/Users/User/Desktop/e-SHOPPER/build/web/images/u" + rs2.getString("customer_id") + ".jpg";
                                                //saveFile = "C:/uploadDir2/" + saveFile;
                                                //out.print(saveFile);
                                                File ff = new File(saveFile);
                                                File ff2 = new File(saveFile2);

                                                try {
                                                    FileOutputStream fileOut = new FileOutputStream(ff);
                                                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                                                    fileOut.flush();
                                                    fileOut.close();
                                                    FileOutputStream fileOut2 = new FileOutputStream(ff2);
                                                    fileOut2.write(dataBytes, startPos, (endPos - startPos));
                                                    fileOut2.flush();
                                                    fileOut2.close();

                                                } catch (Exception e) {
                                                    out.println(e);
                                                }

                                            }
                                        %>
                                        <br><br><br>
.                                        <input type="file" name="file" value="" /><br>

                                        <input type="submit" value="Upload" name="submit" />
                                    </form>
                                    <%
                                    } else {

                                        String saveFile = new String();
                                        String saveFile2 = new String();
                                        String contentType = request.getContentType();
                                        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                                            DataInputStream in = new DataInputStream(request.getInputStream());

                                            int formDataLength = request.getContentLength();
                                            byte dataBytes[] = new byte[formDataLength];
                                            int byteRead = 0;
                                            int totalBytesRead = 0;

                                            while (totalBytesRead < formDataLength) {
                                                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                                                totalBytesRead += byteRead;
                                            }
                                            String file = new String(dataBytes);

                                            saveFile = file.substring(file.indexOf("filename=\"") + 10);
                                            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                                            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));

                                            int lastIndex = contentType.lastIndexOf("=");

                                            String boundary = contentType.substring(lastIndex + 1, contentType.length());

                                            int pos;

                                            pos = file.indexOf("filename=\"");
                                            pos = file.indexOf("\n", pos) + 1;
                                            pos = file.indexOf("\n", pos) + 1;
                                            pos = file.indexOf("\n", pos) + 1;

                                            int boundaryLocation = file.indexOf(boundary, pos) - 4;

                                            int startPos = ((file.substring(0, pos)).getBytes()).length;
                                            int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

                                            Statement stmt9 = db.connection.createStatement();
                                            ResultSet rs9;
                                            rs9 = stmt9.executeQuery("select max(product_code)+1 as mx from product");
                                            rs9.next();

                                            saveFile = "C:/Users/User/Desktop/e-SHOPPER/web/images/u" + rs2.getString("customer_id") + ".jpg";
                                            saveFile2 = "C:/Users/User/Desktop/e-SHOPPER/build/web/images/u" + rs2.getString("customer_id") + ".jpg";
                                            //saveFile = "C:/uploadDir2/" + saveFile;
                                            //out.print(saveFile);
                                            File ff = new File(saveFile);
                                            File ff2 = new File(saveFile2);

                                            try {
                                                FileOutputStream fileOut = new FileOutputStream(ff);
                                                fileOut.write(dataBytes, startPos, (endPos - startPos));
                                                fileOut.flush();
                                                fileOut.close();
                                                FileOutputStream fileOut2 = new FileOutputStream(ff2);
                                                fileOut2.write(dataBytes, startPos, (endPos - startPos));
                                                fileOut2.flush();
                                                fileOut2.close();


                                            } catch (Exception e) {
                                                out.println(e);
                                            }

                                        }

                                    %>
                                    Image Selected.
                                    <form method="post" action="account.jsp?is_image_selected=no">
                                        <input type="hidden" name="is_image_selected" value="no">
                                        <button type="submit">reset</button>

                                    </form>
                                    <%}%>
                       </div> 
                          <!-- end of image upload section -->
                
                        <div>
                            <img src=<%=CompanyPic%> alt="Profilepicture" style="height:150px;width:150px;">
                        </div>
                        
                        <form method="post" action="update.jsp">
                            <button type="submit" style="margin-top:  40px;">Your Products</button>
                        </form>
                        
                        <form method="post" action="update.jsp">
                            <button type="submit" style="margin-top:  40px; margin-bottom: 40px">Add Product</button>
                        </form>
                        
                        <form method="post" action="update.jsp">
                            <input type="hidden" name="verify" value="yes">
                            Verify Code:
                            <input type="text" name="code" style="margin-top:  20px;" placeholder="type code here">
                            <button type="submit" style="margin-left:  170px;">Verify</button>
                        </form>
                        
                      
                        
                        
                        <h2>Edit Details:</h2>
                        <div>
                        
                        
                        <form action="account.jsp" method="post">
                            Name:<input type="text" name="fullname" style="margin-left:  160px;" Value="<%=rs2.getString("customer_name")%>"/>
                            House/Street:<input type="text" name="address" style="margin-left:  160px;" Value="<%=rs2.getString("customer_add")%>"/>
                            City<input type="text" name="city" style="margin-left:  160px;" Value="<%=rs2.getString("customer_city")%>"/>
                            New Password<input type="password" name="newpwd" placeholder="Password" style="margin-left:  160px;"/>
                            <input type="hidden" name="changereq" value="yes">
                            *Current Password
                            <input type="password" name="pwd" placeholder="Password" style="margin-left:  160px;"/><br>
                            <button type="submit" class="btn btn-default" style="margin-left: 356px;">Submit</button>
                            <p>* : Required Field</p>
                        </form>
                        <%if (flag == 1) {%>
                        <h2>SUCCESSFULLY UPDATED YOUR DETAILS</h2>
                        <%
                                } else if (flag == 2) {%>
                        <h2>Password Incorrect!</h2>
                        <h2>Try Again</h2>
                        <%}
                                else{
                        %>
                        <h2>Please fill the required fields</h2>
                        
                        <%}%>
                    </div><!--/sign up form-->
                </div>
            </div>
        </section><!--/form-->


        <footer id="footer"><!--Footer-->
            <div class="footer-top">
                <div class="container">
                    <div class="row">
                    </div>
                </div>
            </div>

            <div class="footer-widget">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Service</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="contact-us.jsp">Contact Us</a></li>
                                    <li><a href="faq.jsp">FAQ?s</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Policies</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="term.jsp">Terms of Use</a></li>
                                    <li><a href="privacypolicy.jsp">Privecy Policy</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>About Shopper</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="info.jsp">Company Information</a></li>
                                    <li><a href="about-us.jsp">About Us</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <p class="pull-left">Copyright � 2015 e-SHOPPER Inc. All rights reserved.</p>
                        <p class="pull-right">Developed as <span> Project 300 </span></p>
                    </div>
                </div>
            </div>

        </footer><!--/Footer-->



        <script src="js/jquery.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <%
            } catch (Exception e) {
                out.println("Exception : " + e.getMessage() + "");
            }
        %>

    </body>
</html>
