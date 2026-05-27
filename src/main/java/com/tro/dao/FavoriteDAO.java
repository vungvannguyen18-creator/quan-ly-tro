package com.tro.dao;

import com.tro.entity.Favorite;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class FavoriteDAO {

    public void create(Favorite favorite) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(favorite);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Favorite favorite = em.find(Favorite.class, id);
            if (favorite != null) {
                em.remove(favorite);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Favorite findByUserAndRoom(Long userId, Long roomId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId AND f.room.id = :roomId";
            TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
            query.setParameter("userId", userId);
            query.setParameter("roomId", roomId);
            return query.getResultList().stream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public List<Favorite> findByUserId(Long userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId ORDER BY f.createdAt DESC";
            TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
