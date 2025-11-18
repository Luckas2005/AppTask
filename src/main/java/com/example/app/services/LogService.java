package com.sistema.services;

import com.sistema.models.Log;
import com.sistema.repositories.LogRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class LogService {

    private final LogRepository repo;

    public LogService(LogRepository repo) {
        this.repo = repo;
    }

    public void registrar(String acao, String usuario) {
        repo.save(new Log(acao, usuario, LocalDateTime.now().toString()));
    }
}
