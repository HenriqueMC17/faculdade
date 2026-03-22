/**
 * Configuração e Dados
 */
const API_URL = 'https://69bb60e50915748735b90820.mockapi.io/enrollments';

const courses = [
    {
        id: 1,
        name: "Introdução à Robótica",
        description: "Explore o mundo dos robôs construindo seus próprios modelos com kits educativos. Ideal para despertar o raciocínio lógico.",
        shift: "Manhã (08:00 - 11:00)",
        professors: "Dra. Ana Silveira, Eng. Carlos Lima",
        value: 450.00
    },
    {
        id: 2,
        name: "Pintura & Criatividade",
        description: "Uma jornada pelas cores e formas, estimulando a expressão artística através de diferentes técnicas e materiais.",
        shift: "Tarde (14:00 - 17:00)",
        professors: "Prof. Marcos Arts",
        value: 280.00
    },
    {
        id: 3,
        name: "Inglês Playful",
        description: "Aprendizado da língua inglesa de forma natural através de músicas, jogos e atividades interativas.",
        shift: "Manhã ou Tarde",
        professors: "Miss July, Mr. Brown",
        value: 320.00
    },
    {
        id: 4,
        name: "Musicalização Infantil",
        description: "Desenvolvimento da percepção rítmica e melódica. Introdução a diversos instrumentos de forma lúdica.",
        shift: "Tarde (13:30 - 16:30)",
        professors: "Maestro João Pedro",
        value: 350.00
    }
];

/**
 * Funções para index.html (Listagem)
 */
function renderCourses() {
    const container = document.getElementById('course-list');
    if (!container) return;

    container.innerHTML = courses.map(course => `
        <div class="course-card reveal">
            <span class="course-tag">Extensão</span>
            <h3 class="course-title">${course.name}</h3>
            <p class="course-desc">${course.description}</p>
            <div class="course-info">
                <div class="info-item">
                    <i class="fas fa-clock"></i>
                    <span>${course.shift}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-user-tie"></i>
                    <span>${course.professors}</span>
                </div>
            </div>
            <div class="course-price">R$ ${course.value.toFixed(2).replace('.', ',')}</div>
            <a href="inscricao.html?id=${course.id}" class="btn">Inscrever-se</a>
        </div>
    `).join('');

    // Re-initialize observer for new elements
    if (typeof window.initRevealObserver === 'function') {
        window.initRevealObserver();
    }
}

/**
 * Funções para inscricao.html (Formulário)
 */
function initEnrollmentForm() {
    const form = document.getElementById('enrollment-form');
    if (!form) return;

    // 1. Capturar ID da QueryString
    const urlParams = new URLSearchParams(window.location.search);
    const courseId = parseInt(urlParams.get('id'));
    const selectedCourse = courses.find(c => c.id === courseId);

    if (selectedCourse) {
        document.getElementById('courseName').value = selectedCourse.name;
        document.getElementById('courseValue').value = `R$ ${selectedCourse.value.toFixed(2).replace('.', ',')}`;
    } else {
        alert('Curso não encontrado. Você será redirecionado para a listagem.');
        window.location.href = 'index.html';
    }

    // 2. Lógica de submissão
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const submitBtn = document.getElementById('submit-btn');
        submitBtn.disabled = true;
        submitBtn.innerText = 'Enviando...';

        const formData = {
            studentName: document.getElementById('studentName').value,
            address: document.getElementById('address').value,
            neighborhood: document.getElementById('neighborhood').value,
            city: document.getElementById('city').value,
            number: document.getElementById('number').value,
            zipCode: document.getElementById('zipCode').value,
            complement: document.getElementById('complement').value,
            state: document.getElementById('state').value,
            phone: document.getElementById('phone').value,
            cellphone: document.getElementById('cellphone').value,
            email: document.getElementById('email').value,
            color: document.getElementById('color').value,
            
            fatherName: document.getElementById('fatherName').value,
            fatherBirthday: document.getElementById('fatherBirthday').value,
            fatherBirthplace: document.getElementById('fatherBirthplace').value,
            fatherEducation: document.getElementById('fatherEducation').value,
            fatherProfession: document.getElementById('fatherProfession').value,
            fatherCellphone: document.getElementById('fatherCellphone').value,
            fatherEmail: document.getElementById('fatherEmail').value,
            fatherCpf: document.getElementById('fatherCpf').value,
            fatherIsFinancialRep: document.getElementById('fatherIsFinancialRep').checked,
            
            motherName: document.getElementById('motherName').value,
            motherBirthday: document.getElementById('motherBirthday').value,
            motherBirthplace: document.getElementById('motherBirthplace').value,
            motherEducation: document.getElementById('motherEducation').value,
            motherProfession: document.getElementById('motherProfession').value,
            motherCellphone: document.getElementById('motherCellphone').value,
            motherEmail: document.getElementById('motherEmail').value,
            motherCpf: document.getElementById('motherCpf').value,
            motherIsFinancialRep: document.getElementById('motherIsFinancialRep').checked,
            
            courseId: courseId,
            courseName: selectedCourse.name,
            entryDate: document.getElementById('entryDate').value,
            courseValue: selectedCourse.value,
            paymentInstallments: document.getElementById('paymentInstallments').value
        };

        try {
            const response = await fetch(API_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showModal();
            } else {
                throw new Error('Falha ao salvar os dados.');
            }
        } catch (error) {
            alert('Erro ao enviar inscrição: ' + error.message);
            submitBtn.disabled = false;
            submitBtn.innerText = 'Finalizar Inscrição';
        }
    });
}

function showModal() {
    const overlay = document.getElementById('modal-overlay');
    const modal = overlay.querySelector('.modal');
    
    overlay.style.display = 'flex';
    setTimeout(() => {
        modal.classList.add('active');
    }, 10);
}

/**
 * Lógica de Máscaras e Validações
 */
function applyPhoneMask(input) {
    let value = input.value.replace(/\D/g, "");
    if (value.length > 11) value = value.slice(0, 11);
    
    if (value.length > 10) {
        // (00) 00000-0000
        input.value = `(${value.slice(0, 2)}) ${value.slice(2, 7)}-${value.slice(7)}`;
    } else if (value.length > 6) {
        // (00) 0000-0000
        input.value = `(${value.slice(0, 2)}) ${value.slice(2, 6)}-${value.slice(6)}`;
    } else if (value.length > 2) {
        input.value = `(${value.slice(0, 2)}) ${value.slice(2)}`;
    } else if (value.length > 0) {
        input.value = `(${value}`;
    }
}

function applyCPFMask(input) {
    let value = input.value.replace(/\D/g, "");
    if (value.length > 11) value = value.slice(0, 11);

    if (value.length > 9) {
        input.value = `${value.slice(0, 3)}.${value.slice(3, 6)}.${value.slice(6, 9)}-${value.slice(9)}`;
    } else if (value.length > 6) {
        input.value = `${value.slice(0, 3)}.${value.slice(3, 6)}.${value.slice(6)}`;
    } else if (value.length > 3) {
        input.value = `${value.slice(0, 3)}.${value.slice(3)}`;
    } else {
        input.value = value;
    }
}

function applyCEPMask(input) {
    let value = input.value.replace(/\D/g, "");
    if (value.length > 8) value = value.slice(0, 8);
    if (value.length > 5) {
        input.value = `${value.slice(0, 5)}-${value.slice(5)}`;
    } else {
        input.value = value;
    }
}

async function handleCEP(cep) {
    cep = cep.replace(/\D/g, "");
    if (cep.length !== 8) return;

    try {
        const response = await fetch(`https://viacep.com.br/ws/${cep}/json/`);
        const data = await response.json();

        if (!data.erro) {
            document.getElementById('address').value = data.logradouro;
            document.getElementById('neighborhood').value = data.bairro;
            document.getElementById('city').value = data.localidade;
            document.getElementById('state').value = data.uf;
            document.getElementById('number').focus();
        }
    } catch (error) {
        console.error("Erro ao buscar CEP:", error);
    }
}

/**
 * Autocomplete
 */
function setupAutocompletes() {
    const naturalidades = ["São Paulo", "Rio de Janeiro", "Belo Horizonte", "Curitiba", "Porto Alegre", "Salvador", "Fortaleza", "Brasília", "Sorocaba", "Campinas", "Santos"];
    const profissoes = ["Engenheiro(a)", "Médico(a)", "Advogado(a)", "Professor(a)", "Analista de Sistemas", "Vendedor(a)", "Autônomo(a)", "Empresário(a)", "Administrador(a)", "Arquiteto(a)", "Dentista"];

    const natList = document.getElementById('naturalidade-list');
    const profList = document.getElementById('profissao-list');

    if (natList) {
        natList.innerHTML = naturalidades.map(n => `<option value="${n}">`).join('');
    }
    if (profList) {
        profList.innerHTML = profissoes.map(p => `<option value="${p}">`).join('');
    }
}

// Iniciar autocompletes
window.addEventListener('DOMContentLoaded', setupAutocompletes);
