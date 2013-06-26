<%@ page contentType="application/pdf" %>

<%@ page trimDirectiveWhitespaces="true"%>

<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.perception.Perception" %>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.engine.data.JRCsvDataSource" %>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URL" %>


<%
    EventHandler eventHandler=new EventHandler();

    String eventID=session.getAttribute("eventID").toString();

    ArrayList<Perception> list=eventHandler.getComments(eventID);
    File file = new File(System.getProperty("java.io.tmpdir")+File.separator+"report_"+eventID+".csv");
    file.createNewFile();

    FileWriter fw = new FileWriter(file.getAbsoluteFile());
    BufferedWriter bw = new BufferedWriter(fw);
    bw.write("Name,No,Comment,,");
    for(Perception p : list){
        bw.newLine();
        bw.write(p.getUserID()+","+p.getPerceptionValue()+","+p.getText()+",,");
    }
    bw.close();
    fw.close();

    try {
        //Loading Jasper Report File from Local file system

        InputStream input = new URL("http://proj16.cse.mrt.ac.lk/Sith/event/SithEventComments.jrxml").openStream();

        //Generating the report
        System.out.println("Compiling");
        JasperReport jasperReport = JasperCompileManager.compileReport(input);

        System.out.println("Reporting");
        String[] columnNames = new String[]{"Name", "No", "Comment"};
        JRCsvDataSource ds = new JRCsvDataSource(JRLoader.getLocationInputStream(System.getProperty("java.io.tmpdir")+File.separator+"report_"+eventID+".csv"));
        ds.setRecordDelimiter("\r\n");
        ds.setColumnNames(columnNames);

        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, ds);

        //Exporting the report as a PDF
        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
    } catch (FileNotFoundException e) {
        e.printStackTrace();
    } catch (JRException e) {
        e.printStackTrace();
    }

%>