/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.Project;
import entity.Student;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Dawson
 */
@Stateless
public class StudentFacade extends AbstractFacade<Student> {

    @PersistenceContext(unitName = "manager_systemPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public StudentFacade() {
        super(Student.class);
    }
    @EJB
    ProjectFacade projectFacade;
    @EJB
    StudentFacade studentFacade;

    public String isLogin(String studentId, String studentName) {
        String flag = "falure";
        Query q = em.createQuery("SELECT s FROM Student s WHERE s.id= :sid AND s.name= :sname");
        q.setParameter("sid", studentId);
        q.setParameter("sname", studentName);
        try {
            Student s = (Student) q.getSingleResult();
            if (studentId.equals(s.getId())
                    && studentName.equals(s.getName())) {
                return "success";
            } else {
                return "failure";
            }
        } catch (Exception e) {
            return null;
        }
    }

    public void studentReportUploaded(String studentId) {
        Student s = this.find(studentId);
        if (s != null) {
            System.out.println("student查找成功");
            em.flush();
            s.setReport("1");
            em.merge(s);
        }

    }

//    @张文珍
    public void addProjectID(Project p, Student s) {
        em.flush();
        s.setProjectID(p);
        em.merge(s);
    }

    public void delProjectID(Student s) {
        em.flush();
        s.setProjectID(null);
        em.merge(s);
    }

//    @朱欣悦
    public List<Student> todo(String student_id) {

        Query q = em.createQuery("SELECT s FROM Student s WHERE s.id=:student_id");
        q.setParameter("student_id", student_id);
        Student sp = (Student) q.getSingleResult();
        Query qm = em.createQuery("SELECT s FROM Student s WHERE s.projectID=:projectID");
        qm.setParameter("projectID", sp.getProjectID());
        List<Student> s = qm.getResultList();
        return s;
    }

//       王睿杰
    public void addStudent(String id, String name) {
        try {
            Student s = new Student();
            em.flush();
            s.setId(id);
            s.setName(name);
            em.persist(s);
        } catch (Exception e) {
            throw new EJBException(e.getMessage());
        }
    }

//朱欣悦
    public void dropStudent(String id) {
        try {
            Student s = this.find(id);
            em.remove(s);
        } catch (Exception e) {
            throw new EJBException(e.getMessage());
        }
    }

    public boolean changeStudentView(Student s, String selectProject) {
        Query q = em.createQuery("SELECT s FROM Student s WHERE s.id=:id");
        q.setParameter("id", s.getId());
        Student sp = (Student) q.getSingleResult();
        if (sp != null) {
            em.flush();
//                sp.setName(s.getName());
            sp.setReport(s.getReport());
            sp.setTotalMark(s.getTotalMark());
            if (selectProject == null) {
                sp.setProjectID(null);
            } else {
                Project p = projectFacade.find(selectProject);
                sp.setProjectID(p);
            }
            em.merge(sp);
            return true;
        } else {
            return false;
        }
    }

    public List<Student> lookStudents(String id) {
        Project p = projectFacade.find(id);
        Query q = em.createQuery("SELECT s FROM Student s WHERE s.projectID= :id");
        q.setParameter("id", p);
        List<Student> res = q.getResultList();
        for (Student s : res) {
            System.out.println(s.getId() + s.getName());
        }
        return q.getResultList();
    }
}
