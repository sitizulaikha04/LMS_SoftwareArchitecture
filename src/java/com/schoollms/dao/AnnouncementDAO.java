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
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO announcements(course_id,title,message) VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, announcement.getCourseId());
            ps.setString(2, announcement.getTitle());
            ps.setString(3, announcement.getMessage());

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

    public List<Announcement> getAllAnnouncements(){
        List<Announcement> list = new ArrayList<>();
        try{
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM announcements ORDER BY announcement_id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Announcement a = new Announcement();
                a.setAnnouncementId(rs.getInt("announcement_id"));
                
                // FIXED: Membuang baris setCourse_id bertindih yang menyebabkan ralat kompilasi
                a.setCourseId(rs.getInt("course_id"));
                a.setTitle(rs.getString("title"));
                a.setMessage(rs.getString("message"));
                list.add(a);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    // FUNGSI BARU: Mengemas kini data pengumuman
    public boolean updateAnnouncement(Announcement announcement) {
        boolean status = false;
        String sql = "UPDATE announcements SET course_id=?, title=?, message=? WHERE announcement_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, announcement.getCourseId());
            ps.setString(2, announcement.getTitle());
            ps.setString(3, announcement.getMessage());
            ps.setInt(4, announcement.getAnnouncementId());

            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // FUNGSI BARU: Memadam rekod pengumuman berdasarkan ID
    public boolean deleteAnnouncement(int announcementId) {
        boolean status = false;
        String sql = "DELETE FROM announcements WHERE announcement_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, announcementId);
            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}