package com.luxa.ecommerce.dao.interfaces;

import com.luxa.ecommerce.model.ContactMessage;
import java.util.List;

public interface ContactMessageDAO {
    void save(ContactMessage m);
    List<ContactMessage> findLatest(int max);
}