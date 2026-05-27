package com.tro.dao;

import com.tro.entity.Review;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class ReviewDAO {

    public void create(Review review) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(review);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Review> findByRoomId(Long roomId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT r FROM Review r WHERE r.room.id = :roomId ORDER BY r.createdAt DESC";
            TypedQuery<Review> query = em.createQuery(jpql, Review.class);
            query.setParameter("roomId", roomId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Double getAverageRatingByRoomId(Long roomId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT AVG(r.rating) FROM Review r WHERE r.room.id = :roomId";
            TypedQuery<Double> query = em.createQuery(jpql, Double.class);
            query.setParameter("roomId", roomId);
            Double avg = query.getSingleResult();
            return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
        } finally {
            em.close();
        }
    }

    public List<Review> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT r FROM Review r ORDER BY r.createdAt DESC";
            TypedQuery<Review> query = em.createQuery(jpql, Review.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Review findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Review.class, id);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Review review = em.find(Review.class, id);
            if (review != null) {
                em.remove(review);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
