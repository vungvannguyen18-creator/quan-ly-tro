package com.tro.dao;

import com.tro.entity.Payment;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class PaymentDAO {

    public void create(Payment payment) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(payment);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Payment payment) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(payment);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Payment findByOrderCode(Long orderCode) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM Payment p WHERE p.orderCode = :orderCode";
            TypedQuery<Payment> query = em.createQuery(jpql, Payment.class);
            query.setParameter("orderCode", orderCode);
            return query.getResultList().stream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public List<Payment> findByStudentId(Long studentId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM Payment p WHERE p.booking.student.id = :studentId ORDER BY p.createdAt DESC";
            TypedQuery<Payment> query = em.createQuery(jpql, Payment.class);
            query.setParameter("studentId", studentId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Payment> findByLandlordId(Long landlordId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM Payment p WHERE p.booking.room.owner.id = :landlordId ORDER BY p.createdAt DESC";
            TypedQuery<Payment> query = em.createQuery(jpql, Payment.class);
            query.setParameter("landlordId", landlordId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Payment> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM Payment p ORDER BY p.createdAt DESC";
            TypedQuery<Payment> query = em.createQuery(jpql, Payment.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
