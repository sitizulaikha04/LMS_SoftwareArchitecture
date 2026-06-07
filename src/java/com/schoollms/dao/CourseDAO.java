/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.schoollms.dao;

import com.schoollms.model.Course;
import com.schoollms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    public boolean addCourse(Course course) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO courses(course_name,description,teacher_id) VALUES(?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, course.getCourseName());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getTeacherId());

            int row = ps.executeUpdate();

            if(row > 0){
                status = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    public List<Course> getAllCourses(){

        List<Course> list =
                new ArrayList<>();

        try{

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM courses";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Course c = new Course();

                c.setCourseId(
                        rs.getInt("course_id"));

                c.setCourseName(
                        rs.getString("course_name"));

                c.setDescription(
                        rs.getString("description"));

                c.setTeacherId(
                        rs.getInt("teacher_id"));

                list.add(c);

            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

}