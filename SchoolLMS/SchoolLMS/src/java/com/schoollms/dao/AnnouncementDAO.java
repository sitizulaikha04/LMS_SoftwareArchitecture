/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.schoollms.dao;

import com.schoollms.model.Announcement;
import com.schoollms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {

    public boolean addAnnouncement(Announcement announcement){

        boolean status = false;

        try{

            Connection conn =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO announcements(course_id,title,message) VALUES(?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, announcement.getCourseId());
            ps.setString(2, announcement.getTitle());
            ps.setString(3, announcement.getMessage());

            int row = ps.executeUpdate();

            if(row > 0){
                status = true;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    public List<Announcement> getAllAnnouncements(){

        List<Announcement> list =
                new ArrayList<>();

        try{

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM announcements ORDER BY created_at DESC";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Announcement a =
                        new Announcement();

                a.setAnnouncementId(
                        rs.getInt("announcement_id"));

                a.setCourseId(
                        rs.getInt("course_id"));

                a.setTitle(
                        rs.getString("title"));

                a.setMessage(
                        rs.getString("message"));

                list.add(a);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}