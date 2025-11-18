package com.sistema.models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "logs")
public class Log {
    @Id
    private String id;

    private String acao;
    private String usuario;
    private String data;

    public Log(String acao, String usuario, String data) {
        this.acao = acao;
        this.usuario = usuario;
        this.data = data;
    }
}

