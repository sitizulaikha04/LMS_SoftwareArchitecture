package com.schoollms.dao;

import com.schoollms.model.Submission;
import com.schoollms.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubmissionDAO {

    public boolean submitAssignment(Submission submission) {
        boolean status = false;
        String sql = "INSERT INTO submissions (assignment_id, student_id, file_name, file_path, submission_notes) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, submission.getAssignmentId());
            ps.setInt(2, submission.getStudentId());
            ps.setString(3, submission.getFileName());
            ps.setString(4, submission.getFilePath());
            ps.setString(5, submission.getSubmissionNotes()); // Simpan nilai deskripsi

            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public List<Submission> getSubmissionsByAssignment(int assignmentId) {
        List<Submission> list = new ArrayList<>();
        String sql = "SELECT * FROM submissions WHERE assignment_id=? ORDER BY submit_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Submission s = new Submission();
                s.setSubmissionId(rs.getInt("submission_id"));
                s.setAssignmentId(rs.getInt("assignment_id"));
                s.setStudentId(rs.getInt("student_id"));
                s.setFileName(rs.getString("file_name"));
                s.setFilePath(rs.getString("file_path"));
                s.setSubmitDate(rs.getTimestamp("submit_date"));
                s.setGrade(rs.getDouble("grade"));
                s.setFeedback(rs.getString("feedback"));
                s.setSubmissionNotes(rs.getString("submission_notes")); // Ambil nilai deskripsi dari DB
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean hasSubmitted(int assignmentId, int studentId) {
        boolean submitted = false;
        String sql = "SELECT * FROM submissions WHERE assignment_id=? AND student_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ps.setInt(2, studentId);
            ResultSet rs = ps.executeQuery();
            submitted = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return submitted;
    }

    public boolean gradeSubmission(int submissionId, double grade, String feedback) {
        boolean status = false;
        String sql = "UPDATE submissions SET grade=?, feedback=? WHERE submission_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, grade);
            ps.setString(2, feedback);
            ps.setInt(3, submissionId);
            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public Submission getSubmissionById(int submissionId) {
        Submission s = null;
        String sql = "SELECT * FROM submissions WHERE submission_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, submissionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new Submission();
                s.setSubmissionId(rs.getInt("submission_id"));
                s.setAssignmentId(rs.getInt("assignment_id"));
                s.setStudentId(rs.getInt("student_id"));
                s.setFileName(rs.getString("file_name"));
                s.setFilePath(rs.getString("file_path"));
                s.setSubmitDate(rs.getTimestamp("submit_date"));
                s.setGrade(rs.getDouble("grade"));
                s.setFeedback(rs.getString("feedback"));
                s.setSubmissionNotes(rs.getString("submission_notes"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    public List<Submission> getSubmissionsByStudent(int studentId) {
        List<Submission> list = new ArrayList<>();
        String sql = "SELECT * FROM submissions WHERE student_id = ? ORDER BY submit_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Submission s = new Submission();
                s.setSubmissionId(rs.getInt("submission_id"));
                s.setAssignmentId(rs.getInt("assignment_id"));
                s.setStudentId(rs.getInt("student_id"));
                s.setFileName(rs.getString("file_name"));
                s.setFilePath(rs.getString("file_path"));
                s.setSubmitDate(rs.getTimestamp("submit_date"));
                s.setGrade(rs.getDouble("grade"));
                s.setFeedback(rs.getString("feedback"));
                s.setSubmissionNotes(rs.getString("submission_notes"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}