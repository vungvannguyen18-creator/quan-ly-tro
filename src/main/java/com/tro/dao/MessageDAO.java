package com.tro.dao;

import com.tro.entity.Message;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class MessageDAO {

    public void create(Message message) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(message);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Message> findByConversationId(Long conversationId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT m FROM Message m WHERE m.conversation.id = :conversationId ORDER BY m.createdAt ASC";
            TypedQuery<Message> query = em.createQuery(jpql, Message.class);
            query.setParameter("conversationId", conversationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
