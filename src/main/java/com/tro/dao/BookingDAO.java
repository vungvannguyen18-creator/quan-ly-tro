package com.tro.dao;

import com.tro.entity.Booking;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class BookingDAO {

    public void create(Booking booking) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(booking);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Booking booking) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(booking);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Booking findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Booking.class, id);
        } finally {
            em.close();
        }
    }

    public List<Booking> findByStudentId(Long studentId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b WHERE b.student.id = :studentId ORDER BY b.createdAt DESC";
            TypedQuery<Booking> query = em.createQuery(jpql, Booking.class);
            query.setParameter("studentId", studentId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Booking> findByLandlordId(Long landlordId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b JOIN b.room r WHERE r.owner.id = :landlordId ORDER BY b.createdAt DESC";
            TypedQuery<Booking> query = em.createQuery(jpql, Booking.class);
            query.setParameter("landlordId", landlordId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Booking> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b ORDER BY b.createdAt DESC";
            TypedQuery<Booking> query = em.createQuery(jpql, Booking.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
