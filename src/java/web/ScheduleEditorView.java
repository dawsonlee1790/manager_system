/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entity.Project;
import entity.ProjectSchedule;
import entity.ProjectSchedulePK;
import entity.Student;
import entity.StudentSchedule;
import entity.StudentSchedulePK;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import org.primefaces.context.RequestContext;
import session.ClassPlanFacade;
import session.ProjectFacade;
import session.ProjectScheduleFacade;
import session.StudentFacade;
import session.StudentScheduleFacade;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Dawson
 */
//@ManagedBean(name="scheduleEditorView")
//@SessionScoped
@ManagedBean(name = "scheduleEditorView")
@ViewScoped
public class ScheduleEditorView implements Serializable {

    private String text;
    private String returnmsg;
    private Student student;
    private Project project;
    private Date date;
    private String dateStr;

    @EJB
    private ClassPlanFacade classPlanFacade;
    @EJB
    private StudentFacade studentFacade;
    @EJB
    private ProjectFacade projectFacade;
    @EJB
    private StudentScheduleFacade studentScheduleFacade;
    @EJB
    private ProjectScheduleFacade projectScheduleFacade;

    HttpServletRequest request;
    String realpath;
    web.ManagedBean managedBean;
    web.ScheduleView scheduleView;

    /**
     * Creates a new instance of ScheduleEditorView
     */
//    public ScheduleEditorView() {
    @PostConstruct
    public void init() {
        FacesContext context = FacesContext.getCurrentInstance();
        //获取服务器相对地址
        request = (HttpServletRequest) context.getExternalContext().getRequest();
        realpath = request.getRealPath("/template");
        scheduleView = (web.ScheduleView) context.getApplication()
                .getVariableResolver().resolveVariable(context, "scheduleView");
        student = scheduleView.getStudent();
        project = scheduleView.getProject();
        date = scheduleView.getSelectDate();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        dateStr = sdf.format(date);
        System.out.println("ScheduleEditorView.init():   " + date + ",    " + student + ",    " + project);
        if (student != null) {
            this.readFromMysql();
        } else if (project != null) {
            this.readFromMysql2();
        }
    }

    public void readTemplate() throws FileNotFoundException, UnsupportedEncodingException, IOException {
//         System.out.println(realPath);
        File file = new File(realpath, "/个人进度模板.txt");
        FileInputStream fis = new FileInputStream(file);
        BufferedReader br = new BufferedReader(new InputStreamReader(fis));
        text = null;
        text = br.readLine();
        while (br.ready()) {
            text += br.readLine();
        }
        br.close();
        fis.close();
    }

    public void readStudnetReportTemplate() throws FileNotFoundException, UnsupportedEncodingException, IOException {
//         System.out.println(realPath);
        File file = new File(realpath, "/个人报告模板.txt");
        FileInputStream fis = new FileInputStream(file);
        BufferedReader br = new BufferedReader(new InputStreamReader(fis));
        text = null;
        text = br.readLine();
        while (br.ready()) {
            text += br.readLine();
        }
        br.close();
        fis.close();
    }

    public void readProjectReportTemplate() throws FileNotFoundException, UnsupportedEncodingException, IOException {
//         System.out.println(realPath);
        File file = new File(realpath, "/个人报告模板.txt");
        FileInputStream fis = new FileInputStream(file);
        BufferedReader br = new BufferedReader(new InputStreamReader(fis));
        text = null;
        text = br.readLine();
        while (br.ready()) {
            text += br.readLine();
        }
        br.close();
        fis.close();
    }

    public void readFromMysql() {
        StudentSchedule ss;
        StudentSchedulePK sspk = new StudentSchedulePK();
        sspk.setDate(date);
        sspk.setStudentID(student.getId());
        ss = this.studentScheduleFacade.find(sspk);
        if (ss == null) {
            text = null;
        } else {
            text = ss.getContent();
        }
    }

    public void saveToMysql() {
        StudentSchedulePK sspk = new StudentSchedulePK();
        sspk.setDate(date);
        System.out.println(date);
        sspk.setStudentID(student.getId());
        StudentSchedule ss = studentScheduleFacade.find(sspk);
        if (ss == null) {
            ss = new StudentSchedule();
            ss.setContent(text);
            ss.setStudentSchedulePK(sspk);
            studentScheduleFacade.create(ss);
            returnmsg = "add";
        } else {
            ss.setContent(text);
            studentScheduleFacade.edit(ss);
            returnmsg = "don't add";
        }
////        同时更新存档的报告
//        List<StudentSchedule> ssList = studentScheduleFacade.findByStudentID(student.getId());
//        ClassPlan classPlan = classPlanFacade.find("1");
//        String studentReport = "";
//        for (StudentSchedule s : ssList) {
//            if (s.getStudentSchedulePK().getDate().equals(classPlan.getEndDate())) {
//                //分页代码，打印时候就会呈现其价值  "<div STYLE=\"page-break-after: always;\"/>"这一段是用在print中的分页代码，另一段代码是用在word中的分页代码
//                studentReport = s.getContent() + "<br clear=all style=\"page-break-before:always\" mce_style=\"page-break-before:always\"/>" + "<div STYLE=\"page-break-after: always;\"/>" + studentReport;
//            }
//            studentReport += s.getContent();
//        }
//        student.setReport(studentReport);
//        studentFacade.edit(student);
        this.hideDialog();
    }

    public void readTemplate2() throws FileNotFoundException, UnsupportedEncodingException, IOException {
//         System.out.println(realPath);
        File file = new File(realpath, "/项目进度模板.txt");
        FileInputStream fis = new FileInputStream(file);
        BufferedReader br = new BufferedReader(new InputStreamReader(fis));
        text = null;
        text = br.readLine();
        while (br.ready()) {
            text += br.readLine();
        }
        br.close();
        fis.close();
    }

    public void readFromMysql2() {
        ProjectSchedule ps;
        ProjectSchedulePK pspk = new ProjectSchedulePK();
        pspk.setDate(date);
        pspk.setProjectID(project.getId());
        ps = this.projectScheduleFacade.find(pspk);
        if (ps == null) {
            text = null;
        } else {
            text = ps.getContent();
        }
    }

    public void saveToMysql2() {
        ProjectSchedulePK pspk = new ProjectSchedulePK();
        pspk.setDate(date);
        System.out.println(date);
        pspk.setProjectID(project.getId());
        ProjectSchedule ps = projectScheduleFacade.find(pspk);
        if (ps == null) {
            ps = new ProjectSchedule();
            ps.setContent(text);
            ps.setProjectSchedulePK(pspk);
            projectScheduleFacade.create(ps);
            returnmsg = "add";
        } else {
            ps.setContent(text);
            projectScheduleFacade.edit(ps);
            returnmsg = "don't add";
        }
//        //        同时更新存档的项目报告
//        List<ProjectSchedule> psList = projectScheduleFacade.findByProjectID(project.getId());
//        ClassPlan classPlan = classPlanFacade.find("1");
//        String projectReport = "";
//        for (ProjectSchedule p : psList) {
//            if (p.getProjectSchedulePK().getDate().equals(classPlan.getEndDate())) {
//                //分页代码，打印时候就会呈现其价值  "<div STYLE=\"page-break-after: always;\"/>"这一段是用在print中的分页代码，另一段代码是用在word中的分页代码
//                projectReport = p.getContent() + "<br clear=all style=\"page-break-before:always\" mce_style=\"page-break-before:always\"/>" + "<div STYLE=\"page-break-after: always;\"/>" + projectReport;
//            }
//            projectReport += p.getContent();
//        }
//        project.setReport(projectReport);
//        projectFacade.edit(project);
        this.hideDialog();
    }

    public void hideDialog() {
        RequestContext.getCurrentInstance().closeDialog(returnmsg);
        returnmsg = null;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDateStr() {
        return dateStr;
    }

    public void setDateStr(String dateStr) {
        this.dateStr = dateStr;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

}
