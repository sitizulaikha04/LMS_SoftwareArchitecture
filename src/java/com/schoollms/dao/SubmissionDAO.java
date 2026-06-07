/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.schoollms.dao;

import com.schoollms.model.Submission;
import com.schoollms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubmissionDAO {

    // STUDENT SUBMIT
    public boolean submitAssignment(Submission submission) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO submissions "
                    + "(assignment_id, student_id, file_name, file_path) "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, submission.getAssignmentId());
            ps.setInt(2, submission.getStudentId());
            ps.setString(3, submission.getFileName());
            ps.setString(4, submission.getFilePath());

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // VIEW SUBMISSIONS
    public List<Submission> getSubmissionsByAssignment(
            int assignmentId) {

        List<Submission> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM submissions "
                    + "WHERE assignment_id=? "
                    + "ORDER BY submit_date DESC";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, assignmentId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Submission s =
                        new Submission();

                s.setSubmissionId(
                        rs.getInt("submission_id"));

                s.setAssignmentId(
                        rs.getInt("assignment_id"));

                s.setStudentId(
                        rs.getInt("student_id"));

                s.setFileName(
                        rs.getString("file_name"));

                s.setFilePath(
                        rs.getString("file_path"));

                s.setSubmitDate(
                        rs.getTimestamp("submit_date"));

                s.setGrade(
                        rs.getDouble("grade"));

                s.setFeedback(
                        rs.getString("feedback"));

                list.add(s);
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // CHECK SUBMITTED
    public boolean hasSubmitted(
            int assignmentId,
            int studentId) {

        boolean submitted = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM submissions "
                    + "WHERE assignment_id=? "
                    + "AND student_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, assignmentId);
            ps.setInt(2, studentId);

            ResultSet rs =
                    ps.executeQuery();

            submitted = rs.next();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return submitted;
    }

    // GRADE SUBMISSION
    public boolean gradeSubmission(
            int submissionId,
            double grade,
            String feedback) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE submissions "
                    + "SET grade=?, feedback=? "
                    + "WHERE submission_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setDouble(1, grade);
            ps.setString(2, feedback);
            ps.setInt(3, submissionId);

            status =
                    ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}