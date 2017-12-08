<%@ page import="pkg.Loader" %>
<%@ page import="pkg.WorkTime" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.TreeSet" %>
<%@ page import="pkg.TimePeriod" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.net.URL" %>

<%
    Loader loader = new Loader();

    ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
    InputStream input = classLoader.getResourceAsStream("/data-0.2M.xml");                //ищет в папке /res/
    //InputStream input = getServletContext().getResourceAsStream("/data1-0.2M.xml");         //ищет в папке /web/
    try {
        loader.parseFile(input);
    } catch (Exception e) {
        e.printStackTrace();
    }



%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page test JSP</title>
    <style>
        <%@include file='style.css' %>
    </style>
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
