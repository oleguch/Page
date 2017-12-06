package pkg;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pkg.WorkTime;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.TreeSet;

/**
 * Created by Danya on 24.02.2016.
 */

public class Loader {

    private SimpleDateFormat visitDateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

    private HashMap<Integer, WorkTime> voteStationWorkTimes = new HashMap<>();
    private TreeSet<String> dateVisit = new TreeSet<>();


    public void parseFile(File file) throws Exception
    {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(file);

        fixWorkTimes(doc);
    }


    private void fixWorkTimes(Document doc) throws Exception
    {
        NodeList visits = doc.getElementsByTagName("visit");
        int visitCount = visits.getLength();
        for(int i = 0; i < visitCount; i++)
        {
            Node node = visits.item(i);
            NamedNodeMap attributes = node.getAttributes();

            Integer station = Integer.parseInt(attributes.getNamedItem("station").getNodeValue());
            Date time = visitDateFormat.parse(attributes.getNamedItem("time").getNodeValue());
            addDate(time);

            WorkTime workTime = voteStationWorkTimes.get(station);
            if(workTime == null)
            {
                workTime = new WorkTime();
                voteStationWorkTimes.put(station, workTime);
            }
            workTime.addVisitTime(time.getTime());
        }
    }

    private void addDate(Date time) {
        SimpleDateFormat format = new SimpleDateFormat("dd MMMM yyyy");
        String date = format.format(time);
        dateVisit.add(date);
    }

    public TreeSet<String> getDateVisit() {
        return dateVisit;
    }

    public HashMap<Integer, WorkTime> getVoteStationWorkTimes() {
        return voteStationWorkTimes;
    }
}