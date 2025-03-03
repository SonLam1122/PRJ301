package model;

import java.time.LocalDate;

public class Payment {
    private int paymentId;
    private int userId;
    private int fineId; // ID của khoản phạt (có thể là borrow_id)
    private double amount;
    private LocalDate paymentDate;
    private String paymentMethod;
    private int status; // 0 = chưa trả, 1 = đã trả

    // Constructor đầy đủ
    public Payment(int userId, int fineId, double amount, LocalDate paymentDate, String paymentMethod, int status) {
        this.userId = userId;
        this.fineId = fineId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    // Constructor có ID
    public Payment(int paymentId, int userId, int fineId, double amount, LocalDate paymentDate, String paymentMethod, int status) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.fineId = fineId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    // Getter và Setter
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFineId() {
        return fineId;
    }

    public void setFineId(int fineId) {
        this.fineId = fineId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public LocalDate getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDate paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
