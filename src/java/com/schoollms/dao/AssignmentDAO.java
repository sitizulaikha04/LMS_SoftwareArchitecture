package com.schoollms.dao;

import com.schoollms.model.Assignment;
import com.schoollms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    public boolean addAssignment(Assignment assignment){
        boolean status = false;
        try{
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO assignments(course_id,title,description,due_date) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, assignment.getCourseId());
            ps.setString(2, assignment.getTitle());
            ps.setString(3, assignment.getDescription());
            ps.setDate(4, assignment.getDueDate());

            int row = ps.executeUpdate();
            if(row > 0){
                status = true;
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }

    public List<Assignment> getAllAssignments(){
        List<Assignment> list = new ArrayList<>();
        try{
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM assignments";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Assignment a = new Assignment();
                a.setAssignmentId(rs.getInt("assignment_id"));
                a.setCourseId(rs.getInt("course_id"));
                a.setTitle(rs.getString("title"));
                a.setDescription(rs.getString("description"));
                a.setDueDate(rs.getDate("due_date"));
                list.add(a);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Assignment> getAssignmentsByCourse(int courseId) {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT * FROM assignments WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Assignment a = new Assignment();
                a.setAssignmentId(rs.getInt("assignment_id"));
                a.setCourseId(rs.getInt("course_id"));
                a.setTitle(rs.getString("title"));
                a.setDescription(rs.getString("description"));
                a.setDueDate(rs.getDate("due_date"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // FUNGSI BARU: Mengira bilangan tugasan masuk yang belum disemak (grade = 0 atau null)
    public int getPendingSubmissionsCount(int assignmentId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM submissions WHERE assignment_id = ? AND (grade IS NULL OR grade = 0.0)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}