package exercicios;

import java.util.Scanner;

/**
 * Jogo da Velha (Tic-Tac-Toe) interativo para console.
 * Demonstra manipulação de matrizes bidimensionais, controle de loops e verificação de condições de vitória.
 */
public class JogoDaVelha {
    private final char[][] tabuleiro;
    private char jogadorAtual;

    public JogoDaVelha() {
        tabuleiro = new char[3][3];
        inicializarTabuleiro();
        jogadorAtual = 'X';
    }

    private void inicializarTabuleiro() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                tabuleiro[i][j] = '-';
            }
        }
    }

    public void desenharTabuleiro() {
        System.out.println("\n  0   1   2  Cols");
        for (int i = 0; i < 3; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < 3; j++) {
                System.out.print(tabuleiro[i][j]);
                if (j < 2) System.out.print(" | ");
            }
            System.out.println();
            if (i < 2) System.out.println("  ---------");
        }
        System.out.println();
    }

    public boolean fazerJogada(int linha, int coluna) {
        if (linha < 0 || linha > 2 || coluna < 0 || coluna > 2) {
            System.out.println("❌ Coordenadas fora do tabuleiro! Escolha valores entre 0 e 2.");
            return false;
        }
        if (tabuleiro[linha][coluna] != '-') {
            System.out.println("❌ Esta posição já está ocupada! Escolha outra.");
            return false;
        }
        tabuleiro[linha][coluna] = jogadorAtual;
        return true;
    }

    public void alternarJogador() {
        jogadorAtual = (jogadorAtual == 'X') ? 'O' : 'X';
    }

    public boolean verificarVitoria() {
        // Linhas
        for (int i = 0; i < 3; i++) {
            if (tabuleiro[i][0] == jogadorAtual && tabuleiro[i][1] == jogadorAtual && tabuleiro[i][2] == jogadorAtual) {
                return true;
            }
        }
        // Colunas
        for (int j = 0; j < 3; j++) {
            if (tabuleiro[0][j] == jogadorAtual && tabuleiro[1][j] == jogadorAtual && tabuleiro[2][j] == jogadorAtual) {
                return true;
            }
        }
        // Diagonais
        if (tabuleiro[0][0] == jogadorAtual && tabuleiro[1][1] == jogadorAtual && tabuleiro[2][2] == jogadorAtual) {
            return true;
        }
        if (tabuleiro[0][2] == jogadorAtual && tabuleiro[1][1] == jogadorAtual && tabuleiro[2][0] == jogadorAtual) {
            return true;
        }
        return false;
    }

    public boolean verificarTabuleiroCheio() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (tabuleiro[i][j] == '-') {
                    return false;
                }
            }
        }
        return true;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("❌ JOGO DA VELHA ⭕");
        
        boolean continuarJogando = true;
        while (continuarJogando) {
            JogoDaVelha jogo = new JogoDaVelha();
            boolean rodadaAtiva = true;

            System.out.println("\nNovo jogo iniciado!");

            while (rodadaAtiva) {
                jogo.desenharTabuleiro();
                System.out.println("Vez do jogador: " + jogo.jogadorAtual);
                
                try {
                    System.out.print("Digite a linha (0, 1 ou 2): ");
                    int linha = Integer.parseInt(scanner.nextLine().trim());
                    System.out.print("Digite a coluna (0, 1 ou 2): ");
                    int coluna = Integer.parseInt(scanner.nextLine().trim());

                    if (jogo.fazerJogada(linha, coluna)) {
                        if (jogo.verificarVitoria()) {
                            jogo.desenharTabuleiro();
                            System.out.println("🎉 PARABÉNS! O jogador " + jogo.jogadorAtual + " VENCEU!");
                            rodadaAtiva = false;
                        } else if (jogo.verificarTabuleiroCheio()) {
                            jogo.desenharTabuleiro();
                            System.out.println("🤝 Deu VELHA! O jogo terminou empatado.");
                            rodadaAtiva = false;
                        } else {
                            jogo.alternarJogador();
                        }
                    }
                } catch (NumberFormatException e) {
                    System.out.println("❌ Entrada inválida! Digite apenas os números inteiros 0, 1 ou 2.");
                }
            }

            System.out.print("\nDesejam jogar novamente? (S/N): ");
            String resposta = scanner.nextLine().trim();
            if (!resposta.equalsIgnoreCase("S")) {
                continuarJogando = false;
                System.out.println("Obrigado por jogar! 👋");
            }
        }
        scanner.close();
    }
}
