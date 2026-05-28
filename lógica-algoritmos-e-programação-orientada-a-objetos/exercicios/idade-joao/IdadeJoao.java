package exercicios;

import java.time.Year;
import java.util.Scanner;

/**
 * Comparador de Idades (Exercício Idade de João)
 * Calcula idades a partir do ano de nascimento e determina a diferença entre duas pessoas.
 */
public class IdadeJoao {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int anoAtual = Year.now().getValue();
        
        System.out.println("🎂 COMPARADOR DE IDADES (IDADE DE JOÃO) 🎂\n");

        try {
            System.out.print("Digite o ano de nascimento do João (Ex: 1995): ");
            int anoJoao = Integer.parseInt(scanner.nextLine().trim());

            System.out.print("Digite o nome da outra pessoa: ");
            String nomeOutro = scanner.nextLine().trim();
            if (nomeOutro.isEmpty()) nomeOutro = "Outra Pessoa";

            System.out.print("Digite o ano de nascimento de " + nomeOutro + ": ");
            int anoOutro = Integer.parseInt(scanner.nextLine().trim());

            if (anoJoao > anoAtual || anoOutro > anoAtual || anoJoao < 1900 || anoOutro < 1900) {
                System.out.println("❌ Os anos de nascimento informados são inválidos (devem ser entre 1900 e " + anoAtual + ").");
                return;
            }

            int idadeJoao = anoAtual - anoJoao;
            int idadeOutro = anoAtual - anoOutro;

            System.out.println("\n=================================");
            System.out.println("📊 RESULTADO DA COMPARAÇÃO");
            System.out.println("=================================");
            System.out.println("João tem: " + idadeJoao + " anos.");
            System.out.println(nomeOutro + " tem: " + idadeOutro + " anos.");
            System.out.println("---------------------------------");

            if (idadeJoao > idadeOutro) {
                int diferenca = idadeJoao - idadeOutro;
                System.out.println("👉 João é mais velho que " + nomeOutro + " por " + diferenca + " ano(s).");
            } else if (idadeOutro > idadeJoao) {
                int diferenca = idadeOutro - idadeJoao;
                System.out.println("👉 " + nomeOutro + " é mais velho(a) que João por " + diferenca + " ano(s).");
            } else {
                System.out.println("👉 João e " + nomeOutro + " têm exatamente a mesma idade!");
            }
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Digite apenas números inteiros para os anos.");
        } finally {
            scanner.close();
        }
    }
}
