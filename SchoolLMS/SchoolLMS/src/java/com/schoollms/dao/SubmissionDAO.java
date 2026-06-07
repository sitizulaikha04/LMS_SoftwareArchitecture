/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.schoollms.dao;

import com.schoollms.model.Submission;
import com.schoollms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class SubmissionDAO {

    public boolean submitAssignment(
            Submission submission) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO submissions "
                    + "(assignment_id,student_id,file_name,file_path) "
                    + "VALUES(?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1,
                    submission.getAssignmentId());

            ps.setInt(2,
                    submission.getStudentId());

            ps.setString(3,
                    submission.getFileName());

            ps.setString(4,
                    submission.getFilePath());

            int row =
                    ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}