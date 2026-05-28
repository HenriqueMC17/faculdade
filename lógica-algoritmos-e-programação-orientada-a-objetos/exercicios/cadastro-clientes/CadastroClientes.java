package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Cliente {
    private int id;
    private String nome;
    private String email;
    private String telefone;

    public Cliente(int id, String nome, String email, String telefone) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
    }

    public int getId() { return id; }
    public String getNome() { return nome; }
    public String getEmail() { return email; }
    public String getTelefone() { return telefone; }

    public void setNome(String nome) { this.nome = nome; }
    public void setEmail(String email) { this.email = email; }
    public void setTelefone(String telefone) { this.telefone = telefone; }

    @Override
    public String toString() {
        return String.format("ID: %d | Nome: %-15s | E-mail: %-25s | Tel: %s", id, nome, email, telefone);
    }
}

public class CadastroClientes {
    private final List<Cliente> listaClientes = new ArrayList<>();
    private int proximoId = 1;

    public void adicionarCliente(String nome, String email, String telefone) {
        Cliente novoCliente = new Cliente(proximoId++, nome, email, telefone);
        listaClientes.add(novoCliente);
        System.out.println("✅ Cliente cadastrado com sucesso! ID gerado: " + novoCliente.getId());
    }

    public void listarClientes() {
        System.out.println("\n👥 LISTA DE CLIENTES CADASTRADOS:");
        if (listaClientes.isEmpty()) {
            System.out.println("(Nenhum cliente cadastrado no sistema)");
            return;
        }
        for (Cliente c : listaClientes) {
            System.out.println(c);
        }
    }

    public Cliente buscarPorId(int id) {
        for (Cliente c : listaClientes) {
            if (c.getId() == id) {
                return c;
            }
        }
        return null;
    }

    public void atualizarCliente(int id, String novoNome, String novoEmail, String novoTel) {
        Cliente c = buscarPorId(id);
        if (c == null) {
            System.out.println("❌ Cliente com ID " + id + " não encontrado.");
            return;
        }
        if (!novoNome.isEmpty()) c.setNome(novoNome);
        if (!novoEmail.isEmpty()) c.setEmail(novoEmail);
        if (!novoTel.isEmpty()) c.setTelefone(novoTel);
        System.out.println("✅ Cadastro atualizado com sucesso!");
    }

    public void removerCliente(int id) {
        Cliente c = buscarPorId(id);
        if (c == null) {
            System.out.println("❌ Cliente com ID " + id + " não encontrado.");
            return;
        }
        listaClientes.remove(c);
        System.out.println("✅ Cliente \"" + c.getNome() + "\" removido com sucesso.");
    }

    public static void main(String[] args) {
        CadastroClientes sistema = new CadastroClientes();
        Scanner scanner = new Scanner(System.in);
        
        // Clientes de teste
        sistema.adicionarCliente("Carlos Souza", "carlos@email.com", "(11) 98888-7777");
        sistema.adicionarCliente("Maria Oliveira", "maria@email.com", "(21) 97777-6666");

        boolean rodando = true;
        while (rodando) {
            System.out.println("\n=== 👥 SISTEMA DE CADASTRO DE CLIENTES ===");
            System.out.println("1. Listar Clientes");
            System.out.println("2. Adicionar Cliente");
            System.out.println("3. Atualizar Cliente");
            System.out.println("4. Remover/Excluir Cliente");
            System.out.println("5. Buscar por ID");
            System.out.println("6. Sair");
            System.out.print("Escolha uma opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        sistema.listarClientes();
                        break;
                    case 2:
                        System.out.print("Nome: ");
                        String nome = scanner.nextLine().trim();
                        System.out.print("E-mail: ");
                        String email = scanner.nextLine().trim();
                        System.out.print("Telefone: ");
                        String tel = scanner.nextLine().trim();
                        
                        if (nome.isEmpty() || email.isEmpty()) {
                            System.out.println("❌ Nome e E-mail são campos obrigatórios.");
                        } else {
                            sistema.adicionarCliente(nome, email, tel);
                        }
                        break;
                    case 3:
                        System.out.print("Informe o ID do cliente que deseja atualizar: ");
                        int idAlt = Integer.parseInt(scanner.nextLine().trim());
                        Cliente cExistente = sistema.buscarPorId(idAlt);
                        if (cExistente == null) {
                            System.out.println("❌ Cliente não encontrado!");
                            break;
                        }
                        System.out.print("Novo Nome (ou Enter para manter [" + cExistente.getNome() + "]): ");
                        String nNome = scanner.nextLine().trim();
                        System.out.print("Novo E-mail (ou Enter para manter [" + cExistente.getEmail() + "]): ");
                        String nEmail = scanner.nextLine().trim();
                        System.out.print("Novo Tel (ou Enter para manter [" + cExistente.getTelefone() + "]): ");
                        String nTel = scanner.nextLine().trim();
                        sistema.atualizarCliente(idAlt, nNome, nEmail, nTel);
                        break;
                    case 4:
                        System.out.print("Informe o ID do cliente a ser removido: ");
                        int idRem = Integer.parseInt(scanner.nextLine().trim());
                        sistema.removerCliente(idRem);
                        break;
                    case 5:
                        System.out.print("Digite o ID para busca: ");
                        int idBusca = Integer.parseInt(scanner.nextLine().trim());
                        Cliente cBuscado = sistema.buscarPorId(idBusca);
                        if (cBuscado != null) {
                            System.out.println("\n🔍 Resultado da Busca:");
                            System.out.println(cBuscado);
                        } else {
                            System.out.println("❌ Cliente não encontrado.");
                        }
                        break;
                    case 6:
                        rodando = false;
                        System.out.println("Saindo do sistema de cadastro de clientes. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida.");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Formato numérico incorreto. Tente novamente.");
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
