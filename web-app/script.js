// Datos simulados para la demostración web
const productosDemo = [
    {
        id: 1,
        nombre: "Cien años de soledad",
        categoria: "Literatura",
        precio_compra: 25.00,
        precio_venta: 35.00,
        stock_actual: 50,
        stock_minimo: 10,
        proveedor: "Editorial Penguin Random House",
        estado: "active"
    },
    {
        id: 2,
        nombre: "El principito",
        categoria: "Infantil",
        precio_compra: 15.00,
        precio_venta: 22.00,
        stock_actual: 30,
        stock_minimo: 5,
        proveedor: "Editorial Penguin Random House",
        estado: "active"
    },
    {
        id: 3,
        nombre: "SQL Server Guía Completa 2023",
        categoria: "Tecnología",
        precio_compra: 40.00,
        precio_venta: 55.00,
        stock_actual: 20,
        stock_minimo: 3,
        proveedor: "Librería Nacional S.A.",
        estado: "active"
    },
    {
        id: 4,
        nombre: "Cuaderno Universitario Rayado",
        categoria: "Oficina",
        precio_compra: 3.00,
        precio_venta: 5.00,
        stock_actual: 100,
        stock_minimo: 20,
        proveedor: "Papelería Moderna EIRL",
        estado: "active"
    },
    {
        id: 5,
        nombre: "Lapicero Azul Pilot",
        categoria: "Oficina",
        precio_compra: 2.50,
        precio_venta: 4.00,
        stock_actual: 200,
        stock_minimo: 30,
        proveedor: "Papelería Moderna EIRL",
        estado: "active"
    },
    {
        id: 6,
        nombre: "Física Universitaria Vol. 1",
        categoria: "Educación",
        precio_compra: 35.00,
        precio_venta: 48.00,
        stock_actual: 15,
        stock_minimo: 5,
        proveedor: "Distribuidora ABC Internacional",
        estado: "active"
    },
    {
        id: 7,
        nombre: "El arte de la guerra",
        categoria: "Autoayuda",
        precio_compra: 18.00,
        precio_venta: 25.00,
        stock_actual: 2,
        stock_minimo: 8,
        proveedor: "Editorial Planeta Perú",
        estado: "active"
    },
    {
        id: 8,
        nombre: "Harry Potter y la piedra filosofal",
        categoria: "Infantil",
        precio_compra: 30.00,
        precio_venta: 42.00,
        stock_actual: 25,
        stock_minimo: 5,
        proveedor: "Editorial Penguin Random House",
        estado: "active"
    }
];

// Obtener categorías únicas
const categorias = [...new Set(productosDemo.map(p => p.categoria))];

// Estado de la aplicación
let estado = {
    productos: productosDemo,
    filtroCategoria: 'all',
    busqueda: ''
};

// Inicializar la página
document.addEventListener('DOMContentLoaded', function() {
    cargarFiltroCategorias();
    cargarProductos(estado.productos);
    actualizarEstadisticas();
    setupEventListeners();
});

function cargarFiltroCategorias() {
    const select = document.getElementById('category-filter');
    
    categorias.forEach(categoria => {
        const option = document.createElement('option');
        option.value = categoria;
        option.textContent = categoria;
        select.appendChild(option);
    });
}

function cargarProductos(productos) {
    const container = document.getElementById('productos-container');
    
    if (productos.length === 0) {
        container.innerHTML = '<p class="no-products">No se encontraron productos</p>';
        return;
    }
    
    container.innerHTML = productos.map(producto => `
        <div class="product-card">
            <div class="product-header">
                <h4>${producto.nombre}</h4>
                <span class="stock-badge ${getStockClass(producto)}">
                    ${getStockText(producto)}
                </span>
            </div>
            <div class="product-info">
                <p><strong>Categoría:</strong> ${producto.categoria}</p>
                <p><strong>Precio:</strong> S/. ${producto.precio_venta}</p>
                <p><strong>Stock:</strong> ${producto.stock_actual} unidades</p>
                <p><strong>Proveedor:</strong> ${producto.proveedor}</p>
            </div>
        </div>
    `).join('');
}

function getStockClass(producto) {
    if (producto.stock_actual === 0) {
        return 'stock-critical';
    } else if (producto.stock_actual <= producto.stock_minimo) {
        return 'stock-low';
    } else {
        return 'stock-ok';
    }
}

function getStockText(producto) {
    if (producto.stock_actual === 0) {
        return 'Agotado';
    } else if (producto.stock_actual <= producto.stock_minimo) {
        return `Stock Bajo (${producto.stock_actual})`;
    } else {
        return `Stock: ${producto.stock_actual}`;
    }
}

function actualizarEstadisticas() {
    const totalProductos = estado.productos.length;
    const stockBajo = estado.productos.filter(p => p.stock_actual <= p.stock_minimo).length;
    
    document.getElementById('total-productos').textContent = totalProductos;
    document.getElementById('stock-bajo').textContent = stockBajo;
    document.getElementById('categorias').textContent = categorias.length;
}

function setupEventListeners() {
    // Filtro de búsqueda
    document.getElementById('search').addEventListener('input', function(e) {
        estado.busqueda = e.target.value.toLowerCase();
        aplicarFiltros();
    });
    
    // Filtro de categoría
    document.getElementById('category-filter').addEventListener('change', function(e) {
        estado.filtroCategoria = e.target.value;
        aplicarFiltros();
    });
}

function aplicarFiltros() {
    let productosFiltrados = productosDemo;
    
    // Filtrar por búsqueda
    if (estado.busqueda) {
        productosFiltrados = productosFiltrados.filter(producto =>
            producto.nombre.toLowerCase().includes(estado.busqueda) ||
            producto.categoria.toLowerCase().includes(estado.busqueda) ||
            producto.proveedor.toLowerCase().includes(estado.busqueda)
        );
    }
    
    // Filtrar por categoría
    if (estado.filtroCategoria !== 'all') {
        productosFiltrados = productosFiltrados.filter(producto => 
            producto.categoria === estado.filtroCategoria
        );
    }
    
    estado.productos = productosFiltrados;
    cargarProductos(productosFiltrados);
    actualizarEstadisticas();
}