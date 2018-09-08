/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import javax.faces.bean.ManagedBean;
import entity.ClassPlan;
import entity.Project;
import entity.Student;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import session.ClassPlanFacade;
import session.ProjectFacade;
import session.StudentFacade;

/**
 *
 * @author 张文珍
 */
@ManagedBean(name = "jSFManagedBean")
@ViewScoped
public class JSFManagedBean implements Serializable {

    @EJB
    private StudentFacade studentFacade;
    @EJB
    private ClassPlanFacade classPlanFacade;
    @EJB
    private ProjectFacade projectFacade;

    private List<Project> project;
    private List<Student> student = new ArrayList<>();
    private String currentStudent;
    private String currentProject;
    private int countProject;
    private String rowProject;
    web.ManagedBean managedBean;

    private String name;
    private String totalmark;
    private String report;

    private Project selectedProject;
    private List<Project> filteredProjects;

    @PostConstruct
    public void init() {
        FacesContext context = FacesContext.getCurrentInstance();
        managedBean = (web.ManagedBean) context.getApplication()
                .getVariableResolver().resolveVariable(context, "managedBean");
        currentStudent = managedBean.getStudentId();
//        创建的项目ID是他自己的学号
        currentProject = currentStudent;
    }

    public void joinProject() {
        Student s = studentFacade.find(this.currentStudent);
        Project p = projectFacade.find(this.rowProject);
        List<Student> studentList = studentFacade.findAll();
        int count = 0;
        for (Student student : studentList) {
            if (p.equals(student.getProjectID())) {
                count++;
            }
        }
        ClassPlan classPlan = this.classPlanFacade.find("1");
        if (s.getProjectID() == null) {
            if (count < classPlan.getProjectLimitNumber()) {
                studentFacade.addProjectID(p, s);
                FacesMessage message = new FacesMessage("参加项目成功", "");
                FacesContext.getCurrentInstance().addMessage(null, message);
            } else {
                FacesMessage message = new FacesMessage("该项目已经满人", "如果想突破这个限制可以联系老师");
                FacesContext.getCurrentInstance().addMessage(null, message);
            }
        } else {
            FacesMessage message = new FacesMessage("您已有项目，请先退出", "");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }

    }

    public void exitProject() {
        Student s = studentFacade.find(this.currentStudent);
        Project ps = s.getProjectID();
        Project p = projectFacade.find(this.rowProject);
        if (p.equals(ps)) {
            studentFacade.delProjectID(s);
            if (projectFacade.find(rowProject).getHeadman().equals(this.currentStudent)) {
                projectFacade.removeProject(this.rowProject);
                FacesMessage message = new FacesMessage("该项目已删除", "");
                FacesContext.getCurrentInstance().addMessage(null, message);
            }
            FacesMessage message = new FacesMessage("退出项目成功", "");
            FacesContext.getCurrentInstance().addMessage(null, message);
        } else {
            FacesMessage message = new FacesMessage("您没有参与该项目", "");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }
    }

    public void exitMyProject() {
        Student s = studentFacade.find(this.currentStudent);
        Project ps = s.getProjectID();
        if (ps !=null) {
            studentFacade.delProjectID(s);
//            如果他是组长则删除项目
            if (ps.getHeadman().equals(s.getId())) {
                projectFacade.removeProject(ps.getId());
                FacesMessage message = new FacesMessage("您的项目已删除", "");
                FacesContext.getCurrentInstance().addMessage(null, message);
            }
            FacesMessage message = new FacesMessage("退出项目成功", "");
            FacesContext.getCurrentInstance().addMessage(null, message);
        } else {
            FacesMessage message = new FacesMessage("您尚未有参与项目", "");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }
    }

    public void submitProject() {
        Student s = studentFacade.find(this.currentStudent);
        System.out.println(",,,,,,:" + name);
        if (name == null || name.isEmpty()) {
            FacesMessage message = new FacesMessage("项目名称不能为空", "");
            FacesContext.getCurrentInstance().addMessage(null, message);
        } else {
            if (currentProject != null && s.getProjectID() == null) {
                this.setTotalmark(null);
                this.setReport(null);
                projectFacade.addProject(this.currentProject, name, totalmark, report, currentStudent);
                Project p = projectFacade.find(this.currentProject);
                studentFacade.addProjectID(p, s);
                FacesMessage message = new FacesMessage("创建项目成功", "");
                FacesContext.getCurrentInstance().addMessage(null, message);
            } else {
                FacesMessage message = new FacesMessage("您已有项目请先退出", "项目负责人：" + s.getProjectID().getHeadman() + "\n项目名称：" + s.getProjectID().getName());
                FacesContext.getCurrentInstance().addMessage(null, message);
            }
        }
    }

    public void lookStudents() {
        student.clear();
        for (Student s : studentFacade.findAll()) {
            System.out.println(s + ",  " + s.getProjectID() + ",  " + rowProject);
            if (s.getProjectID() != null) {
                if (rowProject.equals(s.getProjectID().getId())) {
                    student.add(s);
                }
            }
        }
    }

    public List<Project> getProject() {
        project = projectFacade.findAll();
        return project;
    }

    public void setProject(List<Project> project) {
        this.project = project;
    }

    public List<Student> getStudent() {
//        student = studentFacade.findAll(); 
        return student;
    }

    public void setStudent(List<Student> student) {
        this.student = student;
    }

    public String getCurrentStudent() {
        return currentStudent;
    }

    public void setCurrentStudent(String currentStudent) {
        this.currentStudent = currentStudent;
    }

    public String getCurrentProject() {
        return currentProject;
    }

    public void setCurrentProject(String currentProject) {
        this.currentProject = currentProject;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTotalmark() {
        return totalmark;
    }

    public void setTotalmark(String totalmark) {
        this.totalmark = totalmark;
    }

    public String getReport() {
        return report;
    }

    public void setReport(String report) {
        this.report = report;
    }

    public int getCountProject() {
        return countProject;
    }

    public void setCountProject(int countProject) {
        projectFacade.countProject();
        this.countProject = countProject;
    }

    public Project getSelectedProject() {
        return selectedProject;
    }

    public void setSelectedProject(Project selectedProject) {
        System.out.println(selectedProject.getId());
        this.selectedProject = selectedProject;
    }

    public String getRowProject() {
        return rowProject;
    }

    public void setRowProject(String rowProject) {
        this.rowProject = rowProject;
    }

    public List<Project> getFilteredProjects() {
        return filteredProjects;
    }

    public void setFilteredProjects(List<Project> filteredProjects) {
        this.filteredProjects = filteredProjects;
    }
}
