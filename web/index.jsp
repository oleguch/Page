<%@ page import="pkg.Loader" %>
<%@ page import="pkg.WorkTime" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.TreeSet" %>

<%
    Loader loader = new Loader();
    /*
    Два дня искал как же мне использовать файл, нашел такую реализацию:
    File file = new File(getServletContext().getRealPath("/"),"res/data-0.2M.xml");
    Вот только ищет он после компиляции и соответственно в папке
    WebApplicationNetBeans/build/web/ - для NetBeans (WebApplicationNetBeans - название папки проекта)
    Page/out/artifacts/Page_war_exploded - для IntelliJ IDEA U (Page - название паапки проекта)
    Воти пришлось выкручиваться, придумывать странные относительные пути
    Есть ли более простой способ?
    */
    File file = new File(getServletContext().getRealPath("/"),"../../../res/data-0.2M.xml");
    System.out.println(file.exists());
    System.out.println(file.getAbsolutePath());
    if (file.exists())
        loader.parseFile(file);

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page test JSP</title>
</head>
<body>

%>
<%
    TreeSet<String> dates = loader.getDateVisit();
    HashMap<Integer, WorkTime> voteStationWorkTimes = loader.getVoteStationWorkTimes();
    if (!dates.isEmpty() && !voteStationWorkTimes.isEmpty()) { %>
<table>
    <tr>
        <%
    for (String dateVisit: dates) {
        System.out.println(dateVisit);
        out.write("<th>" + dateVisit + "</th>");
    }
        %>
    </tr>
</table>

<%
    }
    for (Integer votingStation : voteStationWorkTimes.keySet()) {
        WorkTime workTime = voteStationWorkTimes.get(votingStation);
        //System.out.println("\t" + votingStation + " - " + workTime);
        out.write(votingStation + "-" + workTime + "<br>");


    }
%>
</body>
</html>
