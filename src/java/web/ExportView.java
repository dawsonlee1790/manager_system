/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entity.Project;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;

import entity.Student;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.ejb.EJB;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;
import session.ProjectFacade;
import session.StudentFacade;

/**
 *
 * @author Dawson
 */
@Named(value = "exportView")
@SessionScoped
public class ExportView implements Serializable {

    private String text;
    private StreamedContent allStudentsReports;
    private StreamedContent allProjectsReports;
    @EJB
    private StudentFacade studentFacade;
    @EJB
    private ProjectFacade projectFacade;

    HttpServletRequest request;
    String realpath;

    public ExportView() {
        FacesContext context = FacesContext.getCurrentInstance();
        request = (HttpServletRequest) context.getExternalContext().getRequest();
        realpath = request.getRealPath("/studentReport");
    }

    public StreamedContent getAllStudentsReports() throws Exception {
//      
        //拼一个标准的HTML格式文档  
        text = "";
        for (Student s : studentFacade.findAll()) {
            if (s.getReport() != null) {
//                 word中的分页代码，打印时候就会呈现其价值
                text += s.getReport() + "<br clear=all style=\"page-break-before:always\" mce_style=\"page-break-before:always\"/>";
            }
        }
        String content = "<html><head><style>" + "</style></head><body>" + text + "</body></html>";
        InputStream is = new ByteArrayInputStream(content.getBytes("GBK"));
//        得到服务器相对路径

        if (realpath != null) {
            OutputStream os = new FileOutputStream(realpath + "/AllStudentsReports.doc");
            POIFSFileSystem fs = new POIFSFileSystem();
            //对应于org.apache.poi.hdf.extractor.WordDocument  
            fs.createDocument(is, "WordDocument");
            fs.writeFilesystem(os);
            os.close();
            is.close();

            InputStream stream = new FileInputStream(realpath + "/AllStudentsReports.doc");
            allStudentsReports = new DefaultStreamedContent(stream, "application/msword", "AllStudentsReports.doc");
            return allStudentsReports;
        } else {
            return null;
        }
    }

    public StreamedContent getAllProjectsReports() throws Exception {
        //拼一个标准的HTML格式文档  
        text = "";
        for (Project p : projectFacade.findAll()) {
            if (p.getReport() != null) {
//                 word中的分页代码，打印时候就会呈现其价值
//这里不添加分页代码了，制作模板的时候自带了分页代码
                text += p.getReport() ;
            }
        }
        String content = "<html><head><style>" + "</style></head><body>" + text + "</body></html>";
        InputStream is = new ByteArrayInputStream(content.getBytes("GBK"));

        if (realpath != null) {
            OutputStream os = new FileOutputStream(realpath + "/AllProjectsReports.doc");
            POIFSFileSystem fs = new POIFSFileSystem();
            //对应于org.apache.poi.hdf.extractor.WordDocument  
            fs.createDocument(is, "WordDocument");
            fs.writeFilesystem(os);
            os.close();
            is.close();

            InputStream stream = new FileInputStream(realpath + "/AllProjectsReports.doc");
            allProjectsReports = new DefaultStreamedContent(stream, "application/msword", "AllProjectsReports.doc");
            return allProjectsReports;
        } else {
            return null;
        }
    }

    public String readAllReports() {
        text = "";
        for (Student s : studentFacade.findAll()) {
            if (s.getReport() != null) {
//                 print中的分页代码，打印时候就会呈现其价值
                text += s.getReport() + "<div STYLE=\"page-break-after: always;\"/>";
            }
        }
        return "allReportsEditor";
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

}
