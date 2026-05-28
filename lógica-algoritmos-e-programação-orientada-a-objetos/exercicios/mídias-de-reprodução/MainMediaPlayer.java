package exercicios;

import java.util.ArrayList;
import java.util.List;

/**
 * Simulador de Reprodutor de Mídias
 * Demonstra o uso de Interfaces, Polimorfismo e Classes Abstratas em Java.
 */
interface ReprodutorMidia {
    void reproduzir();
    void pausar();
    void parar();
    String getInformacoes();
}

abstract class Midia implements ReprodutorMidia {
    protected String titulo;
    protected double duracaoMinutos;
    protected boolean emReproducao;

    public Midia(String titulo, double duracaoMinutos) {
        this.titulo = titulo;
        this.duracaoMinutos = duracaoMinutos;
        this.emReproducao = false;
    }

    public String getTitulo() { return titulo; }

    @Override
    public void pausar() {
        if (emReproducao) {
            emReproducao = false;
            System.out.println("⏸️ \"" + titulo + "\" foi pausado.");
        } else {
            System.out.println("⚠️ \"" + titulo + "\" já está pausado ou não iniciou.");
        }
    }

    @Override
    public void parar() {
        if (emReproducao) {
            emReproducao = false;
        }
        System.out.println("⏹️ Reprodução de \"" + titulo + "\" foi parada.");
    }
}

class AudioPlayer extends Midia {
    private String qualidadeKbps;

    public AudioPlayer(String titulo, double duracaoMinutos, String qualidadeKbps) {
        super(titulo, duracaoMinutos);
        this.qualidadeKbps = qualidadeKbps;
    }

    @Override
    public void reproduzir() {
        emReproducao = true;
        System.out.println("🎵 Tocando música: \"" + titulo + "\" em qualidade " + qualidadeKbps + "...");
    }

    @Override
    public String getInformacoes() {
        return "Música: \"" + titulo + "\" | Duração: " + duracaoMinutos + " min | Qualidade: " + qualidadeKbps;
    }
}

class VideoPlayer extends Midia {
    private String resolucao;
    private boolean legendaAtiva;

    public VideoPlayer(String titulo, double duracaoMinutos, String resolucao) {
        super(titulo, duracaoMinutos);
        this.resolucao = resolucao;
        this.legendaAtiva = false;
    }

    public void alternarLegenda() {
        this.legendaAtiva = !this.legendaAtiva;
        System.out.println("💬 Legendas do vídeo \"" + titulo + "\" foram " + (legendaAtiva ? "ATIVADAS" : "DESATIVADAS") + ".");
    }

    @Override
    public void reproduzir() {
        emReproducao = true;
        System.out.println("🎬 Reproduzindo vídeo: \"" + titulo + "\" em " + resolucao + (legendaAtiva ? " (com legendas)" : "") + "...");
    }

    @Override
    public String getInformacoes() {
        return "Vídeo: \"" + titulo + "\" | Duração: " + duracaoMinutos + " min | Resolução: " + resolucao;
    }
}

public class MainMediaPlayer {
    public static void main(String[] args) {
        System.out.println("🎵🎬 SISTEMA DE MÍDIAS E REPRODUÇÃO 🎬🎵\n");

        List<ReprodutorMidia> playlist = new ArrayList<>();
        playlist.add(new AudioPlayer("Bohemian Rhapsody - Queen", 5.9, "320kbps"));
        playlist.add(new VideoPlayer("Aulas de Programação Java", 12.5, "1080p"));
        playlist.add(new AudioPlayer("Smooth Criminal - Michael Jackson", 4.1, "256kbps"));

        System.out.println("--- 📋 Itens na Playlist ---");
        for (ReprodutorMidia m : playlist) {
            System.out.println(m.getInformacoes());
        }

        System.out.println("\n--- ▶️ Iniciando Reproduções Polimórficas ---");
        for (ReprodutorMidia m : playlist) {
            // Ativa legenda para os vídeos antes de reproduzir
            if (m instanceof VideoPlayer) {
                ((VideoPlayer) m).alternarLegenda();
            }
            m.reproduzir();
            m.pausar();
            m.parar();
            System.out.println();
        }
    }
}
