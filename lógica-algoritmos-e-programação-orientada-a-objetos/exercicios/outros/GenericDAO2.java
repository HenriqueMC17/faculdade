/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import org.eclipse.persistence.sessions.Session;

/**
 *
 * @author Moreno
 */
public class GenericDAO<T> {

    private final EntityManager entityManager;
    private final Class persistentClass;

    public GenericDAO() {
        this.entityManager = ManagerFactory.getEntityManager();
        this.persistentClass = (Class) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }

    public void inserir(T entity) {
        EntityTransaction tx = getEntityManager().getTransaction();

        try {
            tx.begin();
            getEntityManager().persist(entity);
            tx.commit();
        } catch (Throwable t) {
            t.printStackTrace();
            tx.rollback();
        } finally {
            close();
        }
    }

    public void editar(T entity) {
        EntityTransaction tx = getEntityManager().getTransaction();

        try {
            tx.begin();
            getEntityManager().merge(entity);
            tx.commit();
        } catch (Throwable t) {
            t.printStackTrace();
            tx.rollback();
        } finally {
            close();
        }

    }

    public void excluir(T entity) {
        EntityTransaction tx = getEntityManager().getTransaction();

        try {
            tx.begin();
            getEntityManager().remove(entity);
            tx.commit();
        } catch (Throwable t) {
            t.printStackTrace();
            tx.rollback();
        } finally {
            close();
        }
    }

    public List<T> selecionarTodos() throws Exception {
        CriteriaQuery<T> criteria = getEntityManager().getCriteriaBuilder().createQuery(persistentClass);
        criteria.select(criteria.from(persistentClass));
        return getEntityManager().createQuery(criteria).getResultList();
    }

    public T selecionarPorCodigo(int codigo) {
        return (T) getEntityManager().getReference(persistentClass, codigo);
    }

    private void close() {
        if (getEntityManager().isOpen()) {
            getEntityManager().close();
        }
    }
}
