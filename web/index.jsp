<%@ page import="pkg.Loader" %>
<%@ page import="pkg.WorkTime" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.TreeSet" %>
<%@ page import="pkg.TimePeriod" %>

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
    if (file.exists()) {
        try {
            loader.parseFile(file);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page test JSP</title>
</head>
<body>

<%
    TreeSet<String> dates = loader.getDateVisit();
    HashMap<Integer, WorkTime> voteStationWorkTimes = loader.getVoteStationWorkTimes();
    if (!dates.isEmpty() && !voteStationWorkTimes.isEmpty()) { %>
<table>
    <tr>
        <th></th>
            <%
    for (String dateVisit: dates) {
        out.write("<th>" + dateVisit + "</th>");
    }

    out.write("</tr>");

        for (Integer votingStation : voteStationWorkTimes.keySet()) {
            WorkTime workTime = voteStationWorkTimes.get(votingStation);
            out.write("<tr>");
            out.write("<td>" + votingStation + "</td>");
            for (String dateVisit : dates) {
                out.write("<td>");
                for (TimePeriod workingTime : workTime.getPeriods()) {
                    if (workingTime.getDateVisit().equals(dateVisit)) {
                        out.write(workingTime.getTimeVisit());
                        continue;
                    }
                }
                out.write("</td>");
            }
            out.write("</tr>");
        }
    }
%>
</table>
</body>
</html>
