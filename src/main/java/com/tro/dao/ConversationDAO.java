package com.tro.dao;

import com.tro.entity.Conversation;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class ConversationDAO {

    public void create(Conversation conversation) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(conversation);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Conversation conversation) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(conversation);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Conversation findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Conversation.class, id);
        } finally {
            em.close();
        }
    }

    public Conversation findByStudentAndRoom(Long studentId, Long roomId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT c FROM Conversation c WHERE c.student.id = :studentId AND c.room.id = :roomId";
            TypedQuery<Conversation> query = em.createQuery(jpql, Conversation.class);
            query.setParameter("studentId", studentId);
            query.setParameter("roomId", roomId);
            return query.getResultList().stream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public List<Conversation> findByUserId(Long userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT c FROM Conversation c WHERE c.student.id = :userId OR c.landlord.id = :userId ORDER BY c.updatedAt DESC";
            TypedQuery<Conversation> query = em.createQuery(jpql, Conversation.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
