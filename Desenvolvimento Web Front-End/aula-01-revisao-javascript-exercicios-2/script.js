/* ==========================================================================
   Lógica JavaScript — Aula 01 Revisão 2 (Exercícios 1 a 10)
   Prof. Fabrício Tonetto Londero
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  initTabs();
  validarCheckboxesEx5();
});

/* ==========================================================================
   0. NAVEGAÇÃO POR ABAS (TABS)
   ========================================================================== */
function initTabs() {
  const tabs = document.querySelectorAll('.nav-tab');
  const panels = document.querySelectorAll('.tab-panel');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      panels.forEach(p => p.classList.remove('active'));

      tab.classList.add('active');
      const targetId = tab.getAttribute('data-tab');
      const targetPanel = document.getElementById(targetId);
      if (targetPanel) {
        targetPanel.classList.add('active');
      }
    });
  });
}

/* Mapas de Cores */
const CORES = {
  vermelho: '#ef4444',
  verde: '#10b981',
  azul: '#3b82f6',
  amarelo: '#f59e0b'
};

/* ==========================================================================
   EXERCÍCIO 1 — Alterar cor de fundo por botões
   ========================================================================== */
function alterarCorEx1(corNome) {
  const target = document.getElementById('bg-target-ex1');
  if (target && CORES[corNome]) {
    target.style.backgroundColor = CORES[corNome];
  }
}

function resetCorEx1() {
  const target = document.getElementById('bg-target-ex1');
  if (target) {
    target.style.backgroundColor = '';
  }
}

/* ==========================================================================
   EXERCÍCIO 2 — Alterar cor de fundo por links (onmouseover)
   ========================================================================== */
function alterarCorEx2(corNome) {
  const target = document.getElementById('bg-target-ex2');
  if (target && CORES[corNome]) {
    target.style.backgroundColor = CORES[corNome];
  }
}

function restaurarCorEx2() {
  const target = document.getElementById('bg-target-ex2');
  if (target) {
    target.style.backgroundColor = '';
  }
}

/* ==========================================================================
   EXERCÍCIO 3 — Alterar cor de fundo por Select / RadioButton
   ========================================================================== */
function alterarCorEx3Select(corNome) {
  const target = document.getElementById('bg-target-ex3');
  if (target) {
    target.style.backgroundColor = CORES[corNome] || '';
  }
}

function alterarCorEx3Radio(corNome) {
  const target = document.getElementById('bg-target-ex3');
  if (target && CORES[corNome]) {
    target.style.backgroundColor = CORES[corNome];
  }
}

function resetCorEx3() {
  const target = document.getElementById('bg-target-ex3');
  if (target) {
    target.style.backgroundColor = '';
  }
  const select = document.getElementById('select-cor');
  if (select) select.value = '';
  
  const radios = document.querySelectorAll('input[name="radio-cor"]');
  radios.forEach(r => r.checked = false);
}

/* ==========================================================================
   EXERCÍCIO 4 — Ocultar ou mostrar parágrafo
   ========================================================================== */
function toggleParagrafoEx4() {
  const p = document.getElementById('paragrafo-ex4');
  const btn = document.getElementById('btn-toggle-ex4');

  if (!p || !btn) return;

  if (p.style.display === 'none') {
    p.style.display = 'block';
    btn.textContent = 'Ocultar Parágrafo';
    btn.className = 'btn btn-primary';
  } else {
    p.style.display = 'none';
    btn.textContent = 'Mostrar Parágrafo';
    btn.className = 'btn btn-success';
  }
}

/* ==========================================================================
   EXERCÍCIO 5 — Botão habilitado com pelo menos 2 checkboxes
   ========================================================================== */
function validarCheckboxesEx5() {
  const checkboxes = document.querySelectorAll('.ex5-chk');
  const btnSubmit = document.getElementById('btn-submit-ex5');
  const counterSpan = document.getElementById('chk-count-ex5');

  let marcados = 0;
  checkboxes.forEach(chk => {
    if (chk.checked) marcados++;
  });

  if (counterSpan) {
    counterSpan.textContent = marcados;
  }

  if (btnSubmit) {
    btnSubmit.disabled = (marcados < 2);
  }
}

function enviarFormEx5(e) {
  e.preventDefault();
  alert('Formulário enviado com sucesso! Você selecionou pelo menos 2 itens.');
}

/* ==========================================================================
   EXERCÍCIO 6 — Alternar cor da fonte e cor do fundo do parágrafo
   ========================================================================== */
function alterarCorFonteEx6(cor) {
  const p = document.getElementById('paragrafo-ex6');
  if (p) {
    p.style.color = cor;
  }
}

function alterarFundoTextoEx6(cor) {
  const container = document.getElementById('container-texto-ex6');
  if (container) {
    container.style.backgroundColor = cor;
  }
}

/* ==========================================================================
   EXERCÍCIO 7 — Aumentar e diminuir tamanho da fonte
   ========================================================================== */
let tamanhoFonteAtualEx7 = 18; // Tamanho inicial em px

function alterarTamanhoFonteEx7(delta) {
  const p = document.getElementById('paragrafo-ex6');
  const badge = document.getElementById('badge-font-size');

  tamanhoFonteAtualEx7 += delta;
  
  // Limites de segurança (mínimo 10px, máximo 48px)
  if (tamanhoFonteAtualEx7 < 10) tamanhoFonteAtualEx7 = 10;
  if (tamanhoFonteAtualEx7 > 48) tamanhoFonteAtualEx7 = 48;

  if (p) {
    p.style.fontSize = `${tamanhoFonteAtualEx7}px`;
  }
  if (badge) {
    badge.textContent = `${tamanhoFonteAtualEx7}px`;
  }
}

/* ==========================================================================
   EXERCÍCIO 8 — Transformar texto em Maiúscula / Minúscula
   ========================================================================== */
function transformarTextoEx8(tipo) {
  const p = document.getElementById('paragrafo-ex6');
  if (!p) return;

  if (tipo === 'upper') {
    p.textContent = p.textContent.toUpperCase();
  } else if (tipo === 'lower') {
    p.textContent = p.textContent.toLowerCase();
  }
}

/* ==========================================================================
   EXERCÍCIO 9 — Validação de Formulário de Usuário
   ========================================================================== */
function validarUsuarioEx9(event) {
  event.preventDefault();

  const loginInput = document.getElementById('ex9-login');
  const senhaInput = document.getElementById('ex9-senha');
  const confirmarInput = document.getElementById('ex9-confirmar');
  const feedbackMsg = document.getElementById('msg-feedback-ex9');

  const login = loginInput.value.trim();
  const senha = senhaInput.value;
  const confirmar = confirmarInput.value;

  // Ocultar mensagem prévia
  feedbackMsg.style.display = 'none';
  feedbackMsg.className = 'feedback-message';

  // 1. Verificar se todos os campos estão preenchidos
  if (!login || !senha || !confirmar) {
    exibirFeedback(feedbackMsg, 'Por favor, preencha todos os campos do formulário.', 'error');
    return false;
  }

  // 2. Verificar se a senha tem entre 6 e 10 caracteres
  if (senha.length < 6 || senha.length > 10) {
    exibirFeedback(feedbackMsg, 'A senha deve possuir entre 6 e 10 caracteres.', 'error');
    return false;
  }

  // 3. Verificar se as senhas coincidem
  if (senha !== confirmar) {
    exibirFeedback(feedbackMsg, 'Os campos "Senha" e "Confirmar Senha" devem ser iguais.', 'error');
    return false;
  }

  // Sucesso!
  exibirFeedback(feedbackMsg, `Usuário "${login}" cadastrado com sucesso!`, 'success');
  return true;
}

/* Helper para mensagens de feedback */
function exibirFeedback(element, texto, tipo) {
  element.textContent = texto;
  element.className = `feedback-message ${tipo}`;
  element.style.display = 'block';
}

/* ==========================================================================
   EXERCÍCIO 10 — Cadastro de Cliente com Condicionais e Máscara Numérica
   ========================================================================== */

/**
 * Função utilitária para permitir apenas números em tempo de execução
 */
function somenteNumeros(inputElement) {
  inputElement.value = inputElement.value.replace(/\D/g, '');
}

/**
 * Alterna estado dos campos CPF, CNPJ e Data de Nascimento conforme o tipo de pessoa
 */
function alternarTipoPessoaEx10(tipo) {
  const campoCpf = document.getElementById('ex10-cpf');
  const campoCnpj = document.getElementById('ex10-cnpj');
  const campoNascimento = document.getElementById('ex10-nascimento');

  if (tipo === 'fisica') {
    // Ativar CPF e Data de Nascimento
    campoCpf.disabled = false;
    campoNascimento.disabled = false;
    
    // Desativar e limpar CNPJ
    campoCnpj.disabled = true;
    campoCnpj.value = '';
  } else if (tipo === 'juridica') {
    // Ativar CNPJ
    campoCnpj.disabled = false;
    
    // Desativar e limpar CPF e Data de Nascimento
    campoCpf.disabled = true;
    campoCpf.value = '';
    campoNascimento.disabled = true;
    campoNascimento.value = '';
  }
}

/**
 * Validação da submissão do formulário de cliente
 */
function validarClienteEx10(event) {
  event.preventDefault();

  const feedbackMsg = document.getElementById('msg-feedback-ex10');
  const tipoPessoa = document.querySelector('input[name="tipo-pessoa"]:checked').value;
  
  const nome = document.getElementById('ex10-nome').value.trim();
  const cpf = document.getElementById('ex10-cpf').value.trim();
  const cnpj = document.getElementById('ex10-cnpj').value.trim();
  const nascimento = document.getElementById('ex10-nascimento').value.trim();
  const cep = document.getElementById('ex10-cep').value.trim();
  const endereco = document.getElementById('ex10-endereco').value.trim();
  const email = document.getElementById('ex10-email').value.trim();

  // Validações básicas
  if (!nome || !endereco || !email || !cep) {
    exibirFeedback(feedbackMsg, 'Por favor, preencha todos os campos obrigatórios (*).', 'error');
    return false;
  }

  if (tipoPessoa === 'fisica') {
    if (!cpf) {
      exibirFeedback(feedbackMsg, 'Para Pessoa Física, o campo CPF é obrigatório.', 'error');
      return false;
    }
    if (!nascimento) {
      exibirFeedback(feedbackMsg, 'Para Pessoa Física, o campo Data de Nascimento é obrigatório.', 'error');
      return false;
    }
  } else if (tipoPessoa === 'juridica') {
    if (!cnpj) {
      exibirFeedback(feedbackMsg, 'Para Pessoa Jurídica, o campo CNPJ é obrigatório.', 'error');
      return false;
    }
  }

  // Sucesso
  exibirFeedback(feedbackMsg, `Cliente "${nome}" cadastrado com sucesso! (${tipoPessoa === 'fisica' ? 'Pessoa Física' : 'Pessoa Jurídica'})`, 'success');
  return true;
}
