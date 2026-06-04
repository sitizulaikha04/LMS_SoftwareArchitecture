package com.lms.model;

public class Course {

    private String code;
    private String name;
    private String teacher;

    public Course(String code, String name, String teacher) {
        this.code = code;
        this.name = name;
        this.teacher = teacher;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public String getTeacher() {
        return teacher;
    }
}