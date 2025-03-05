/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author MSI
 */
public class ChartItem {

    private Date date;  // Ngày
    private int borrowedCount;  // Số lượng sách mượn trong ngày
    private int returnedCount;  // Số lượng sách đã trả trong ngày

    public ChartItem() {
    }

    public ChartItem(Date date, int borrowedCount, int returnedCount) {
        this.date = date;
        this.borrowedCount = borrowedCount;
        this.returnedCount = returnedCount;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getBorrowedCount() {
        return borrowedCount;
    }

    public void setBorrowedCount(int borrowedCount) {
        this.borrowedCount = borrowedCount;
    }

    public int getReturnedCount() {
        return returnedCount;
    }

    public void setReturnedCount(int returnedCount) {
        this.returnedCount = returnedCount;
    }

    @Override
    public String toString() {
        return "ChartItem{" + "date=" + date + ", borrowedCount=" + borrowedCount + ", returnedCount=" + returnedCount + '}';
    }
    
    
    
}
