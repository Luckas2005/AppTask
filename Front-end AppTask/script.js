// ELEMENTOS DA TELA DE LOGIN
const loginPage = document.getElementById("loginPage");
const appPage = document.getElementById("appPage");
const loginForm = document.getElementById("loginForm");
const userEmailDisplay = document.getElementById("userEmailDisplay");
const logoutBtn = document.getElementById("logoutBtn");

// ELEMENTOS DA TELA PRINCIPAL
const taskInput = document.getElementById("taskInput");
const addTaskBtn = document.getElementById("addTaskBtn");
const tasksList = document.getElementById("tasksList");
const emptyState = document.getElementById("emptyState");

let tasks = []; // Aqui ficam as tarefas

// LOGIN SIMPLES (DEMO)
loginForm.addEventListener("submit", function (e) {
  e.preventDefault();

  const email = document.getElementById("email").value.trim();

  userEmailDisplay.textContent = email;
  loginPage.style.display = "none";
  appPage.style.display = "flex";
});

// LOGOUT
logoutBtn.addEventListener("click", function () {
  appPage.style.display = "none";
  loginPage.style.display = "flex";
  loginForm.reset();
  tasks = [];
  renderTasks();
});

// ---------------------- CRUD ----------------------

// CREATE
function addTask() {
  const text = taskInput.value.trim();
  if (!text) return;

  const newTask = {
    id: Date.now(),
    title: text,
    done: false
  };

  tasks.push(newTask);
  taskInput.value = "";
  renderTasks();
}

// READ – renderizar lista
function renderTasks() {
  tasksList.innerHTML = "";

  if (tasks.length === 0) {
    emptyState.style.display = "block";
    return;
  }

  emptyState.style.display = "none";

  tasks.forEach(task => {
    const li = document.createElement("li");
    li.className = "task-item";

    const leftDiv = document.createElement("div");
    leftDiv.className = "task-left";

    const checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.className = "task-checkbox";
    checkbox.checked = task.done;

    checkbox.addEventListener("change", () => {
      updateTaskStatus(task.id, checkbox.checked);
    });

    const title = document.createElement("span");
    title.className = "task-title";
    title.textContent = task.title;

    if (task.done) {
      title.classList.add("done");
    }

    leftDiv.appendChild(checkbox);
    leftDiv.appendChild(title);

    const rightDiv = document.createElement("div");
    rightDiv.className = "task-right";

    // UPDATE – botão editar
    const editBtn = document.createElement("button");
    editBtn.className = "edit-btn";
    editBtn.style.border = "none";
    editBtn.style.background = "transparent";
    editBtn.style.cursor = "pointer";
    editBtn.style.fontSize = "1.1rem";
    editBtn.textContent = "✏️";

    editBtn.addEventListener("click", () => {
      editTask(task.id);
    });

    // DELETE – botão excluir
    const deleteBtn = document.createElement("button");
    deleteBtn.className = "delete-btn";
    deleteBtn.innerHTML = "&times;";

    deleteBtn.addEventListener("click", () => {
      deleteTask(task.id);
    });

    rightDiv.appendChild(editBtn);
    rightDiv.appendChild(deleteBtn);

    li.appendChild(leftDiv);
    li.appendChild(rightDiv);
    tasksList.appendChild(li);
  });
}

// UPDATE – editar título da tarefa
function editTask(id) {
  const task = tasks.find(t => t.id === id);
  if (!task) return;

  const novoTitulo = prompt("Editar tarefa:", task.title);

  if (novoTitulo !== null && novoTitulo.trim() !== "") {
    task.title = novoTitulo.trim();
    renderTasks();
  }
}

// UPDATE – marcar como concluída
function updateTaskStatus(id, done) {
  const task = tasks.find(t => t.id === id);
  if (task) {
    task.done = done;
    renderTasks();
  }
}

// DELETE
function deleteTask(id) {
  tasks = tasks.filter(t => t.id !== id);
  renderTasks();
}

// EVENTOS
addTaskBtn.addEventListener("click", addTask);

taskInput.addEventListener("keydown", function (e) {
  if (e.key === "Enter") {
    e.preventDefault();
    addTask();
  }
});

// INICIALIZA
renderTasks();
