package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Sanduiche {
    private String pao;
    private String carne;
    private String queijo;
    private List<String> saladas = new ArrayList<>();
    private List<String> molhos = new ArrayList<>();
    private double precoBase = 10.00;

    public Sanduiche(String pao, String carne, String queijo) {
        this.pao = pao;
        this.carne = carne;
        this.queijo = queijo;
    }

    public void adicionarSalada(String item) {
        saladas.add(item);
    }

    public void adicionarMolho(String item) {
        molhos.add(item);
    }

    public double calcularPreco() {
        double total = precoBase;
        // Taxas por carne
        if (carne.equalsIgnoreCase("Picanha")) total += 7.00;
        else if (carne.equalsIgnoreCase("Frango Grelhado")) total += 4.50;
        else if (carne.equalsIgnoreCase("Vegetariano (Grão de Bico)")) total += 3.50;
        
        // Taxas por queijo
        if (queijo.equalsIgnoreCase("Cheddar")) total += 2.50;
        else if (queijo.equalsIgnoreCase("Prato")) total += 2.00;
        
        // Adicionais de salada e molho (R$ 0.50 cada)
        total += saladas.size() * 0.50;
        total += molhos.size() * 0.50;
        
        return total;
    }

    public void exibirRecibo() {
        System.out.println("\n=================================");
        System.out.println("🍔 RECIBO DO SEU SANDUÍCHE");
        System.out.println("=================================");
        System.out.println("Pão      : " + pao);
        System.out.println("Proteína : " + carne);
        System.out.println("Queijo   : " + queijo);
        System.out.println("Saladas  : " + (saladas.isEmpty() ? "Nenhuma" : String.join(", ", saladas)));
        System.out.println("Molhos   : " + (molhos.isEmpty() ? "Nenhum" : String.join(", ", molhos)));
        System.out.println("---------------------------------");
        System.out.printf("VALOR TOTAL: R$ %.2f\n", calcularPreco());
        System.out.println("=================================");
    }
}

public class PedidoSanduiche {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🍔 MONTE SEU SANDUÍCHE - SUBWAY STYLE 🍔\n");

        try {
            // 1. Tipo de Pão
            System.out.println("Escolha o Pão:");
            System.out.println("1. Três Queijos");
            System.out.println("2. Italiano");
            System.out.println("3. Integral");
            System.out.print("Escolha (1-3): ");
            int opcaoPao = Integer.parseInt(scanner.nextLine().trim());
            String pao = "Italiano";
            if (opcaoPao == 1) pao = "Três Queijos";
            else if (opcaoPao == 3) pao = "Integral";

            // 2. Proteína
            System.out.println("\nEscolha a Proteína:");
            System.out.println("1. Picanha (Adicional R$ 7,00)");
            System.out.println("2. Frango Grelhado (Adicional R$ 4,50)");
            System.out.println("3. Vegetariano (Grão de Bico) (Adicional R$ 3,50)");
            System.out.print("Escolha (1-3): ");
            int opcaoCarne = Integer.parseInt(scanner.nextLine().trim());
            String carne = "Frango Grelhado";
            if (opcaoCarne == 1) carne = "Picanha";
            else if (opcaoCarne == 3) carne = "Vegetariano (Grão de Bico)";

            // 3. Queijo
            System.out.println("\nEscolha o Queijo:");
            System.out.println("1. Cheddar (Adicional R$ 2,50)");
            System.out.println("2. Prato (Adicional R$ 2,00)");
            System.out.println("3. Sem queijo");
            System.out.print("Escolha (1-3): ");
            int opcaoQueijo = Integer.parseInt(scanner.nextLine().trim());
            String queijo = "Sem queijo";
            if (opcaoQueijo == 1) queijo = "Cheddar";
            else if (opcaoQueijo == 2) queijo = "Prato";

            Sanduiche sanduiche = new Sanduiche(pao, carne, queijo);

            // 4. Saladas
            System.out.print("\nDeseja adicionar Alface? (S/N): ");
            if (scanner.nextLine().trim().equalsIgnoreCase("S")) sanduiche.adicionarSalada("Alface");
            
            System.out.print("Deseja adicionar Tomate? (S/N): ");
            if (scanner.nextLine().trim().equalsIgnoreCase("S")) sanduiche.adicionarSalada("Tomate");

            System.out.print("Deseja adicionar Cebola Roxa? (S/N): ");
            if (scanner.nextLine().trim().equalsIgnoreCase("S")) sanduiche.adicionarSalada("Cebola Roxa");

            // 5. Molhos
            System.out.print("\nDeseja adicionar Molho Barbecue? (S/N): ");
            if (scanner.nextLine().trim().equalsIgnoreCase("S")) sanduiche.adicionarMolho("Barbecue");

            System.out.print("Deseja adicionar Maionese Temperada? (S/N): ");
            if (scanner.nextLine().trim().equalsIgnoreCase("S")) sanduiche.adicionarMolho("Maionese Temperada");

            // Exibir o Recibo
            sanduiche.exibirRecibo();

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Pedido cancelado.");
        } catch (Exception e) {
            System.out.println("❌ Erro: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
