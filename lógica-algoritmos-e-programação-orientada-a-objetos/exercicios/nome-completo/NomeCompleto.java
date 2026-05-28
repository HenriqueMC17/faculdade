package exercicios;

import java.util.Scanner;

/**
 * Analisador e Formatador de Nome Completo
 * Demonstra o uso de métodos de String (split, substring, charAt, replace, etc.).
 */
public class NomeCompleto {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("📝 ANALISADOR DE NOME COMPLETO 📝");

        try {
            System.out.print("Digite seu nome completo: ");
            String nomeCompleto = scanner.nextLine().trim();

            if (nomeCompleto.isEmpty()) {
                System.out.println("❌ Nome não pode ser vazio.");
                return;
            }

            String[] partes = nomeCompleto.split("\\s+");
            if (partes.length < 2) {
                System.out.println("⚠️ Por favor, digite nome e sobrenome.");
            }

            String maiusculo = nomeCompleto.toUpperCase();
            String minusculo = nomeCompleto.toLowerCase();
            int quantLetras = nomeCompleto.replace(" ", "").length();
            
            String primeiroNome = partes[0];
            String ultimoNome = partes[partes.length - 1];

            // Criar nome abreviado (ex: João da Silva Santos -> João D. S. Santos)
            StringBuilder abreviado = new StringBuilder();
            abreviado.append(primeiroNome).append(" ");
            for (int i = 1; i < partes.length - 1; i++) {
                String parte = partes[i];
                // Ignorar conectores comuns em português (de, da, do, dos, das, e)
                if (parte.equalsIgnoreCase("de") || parte.equalsIgnoreCase("da") || 
                    parte.equalsIgnoreCase("do") || parte.equalsIgnoreCase("dos") || 
                    parte.equalsIgnoreCase("das") || parte.equalsIgnoreCase("e")) {
                    abreviado.append(parte.toLowerCase()).append(" ");
                } else {
                    abreviado.append(parte.toUpperCase().charAt(0)).append(". ");
                }
            }
            if (partes.length > 1) {
                abreviado.append(ultimoNome);
            }

            System.out.println("\n=================================");
            System.out.println("📊 RESULTADOS DA ANÁLISE");
            System.out.println("=================================");
            System.out.println("Nome Informado      : " + nomeCompleto);
            System.out.println("Maiúsculo           : " + maiusculo);
            System.out.println("Minúsculo           : " + minusculo);
            System.out.println("Total de letras     : " + quantLetras);
            System.out.println("Primeiro Nome       : " + primeiroNome);
            System.out.println("Último Sobrenome    : " + ultimoNome);
            System.out.println("Nome Abreviado      : " + abreviado.toString().trim());
            System.out.println("=================================");

        } catch (Exception e) {
            System.out.println("❌ Ocorreu um erro: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
