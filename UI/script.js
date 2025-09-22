// Dashboard functionality
class Dashboard {
    constructor() {
        this.init();
    }

    init() {
        this.initNotifications();
        this.initGridViews();
        this.initFormValidation();
        this.initAnimations();
    }

    // Initialize notification system
    initNotifications() {
        window.showToast = this.showToast;
    }

    // Show toast notification
    showToast(message, type = 'success', duration = 5000) {
        const toastContainer = document.querySelector('.toast-container') || this.createToastContainer();
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;
        toast.innerHTML = `
            <div class="toast-icon">
                <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
            </div>
            <div class="toast-content">
                <p>${message}</p>
            </div>
            <button class="toast-close" onclick="this.parentElement.remove()">
                <i class="fas fa-times"></i>
            </button>
        `;

        toastContainer.appendChild(toast);

        // Auto remove after duration
        setTimeout(() => {
            if (toast.parentElement) {
                toast.remove();
            }
        }, duration);
    }

    createToastContainer() {
        const container = document.createElement('div');
        container.className = 'toast-container';
        document.body.appendChild(container);
        return container;
    }

    // Enhance GridView functionality
    initGridViews() {
        const gridViews = document.querySelectorAll('.grid-view');

        gridViews.forEach(grid => {
            // Add hover effects
            const rows = grid.querySelectorAll('tr');
            rows.forEach((row, index) => {
                if (index > 0) { // Skip header row
                    row.addEventListener('mouseenter', () => {
                        row.style.transform = 'scale(1.01)';
                        row.style.zIndex = '1';
                    });

                    row.addEventListener('mouseleave', () => {
                        row.style.transform = 'scale(1)';
                        row.style.zIndex = '0';
                    });
                }
            });

            // Add pagination indicators
            this.addPaginationInfo(grid);
        });
    }

    addPaginationInfo(grid) {
        const rowCount = grid.querySelectorAll('tr').length - 1; // Exclude header
        if (rowCount > 0) {
            const info = document.createElement('div');
            info.className = 'grid-info';
            info.innerHTML = `Showing ${rowCount} records`;
            info.style.cssText = 'margin-top: 10px; font-size: 14px; color: #666; text-align: right;';
            grid.parentNode.appendChild(info);
        }
    }

    // Enhanced form validation
    initFormValidation() {
        const forms = document.querySelectorAll('form');

        forms.forEach(form => {
            form.addEventListener('submit', (e) => {
                const submitBtn = form.querySelector('button[type="submit"], input[type="submit"]');
                if (submitBtn) {
                    submitBtn.innerHTML = '<span class="loading"></span> Processing...';
                    submitBtn.disabled = true;
                }
            });
        });

        // Real-time validation
        const inputs = document.querySelectorAll('input[required], textarea[required]');
        inputs.forEach(input => {
            input.addEventListener('blur', () => {
                this.validateField(input);
            });
        });
    }

    validateField(field) {
        if (!field.value.trim()) {
            field.style.borderColor = '#f72585';
            this.showToast(`${field.name || 'Field'} is required`, 'error', 3000);
        } else {
            field.style.borderColor = '#4cc9f0';
        }
    }

    // Initialize animations
    initAnimations() {
        this.animateStats();
        this.observeSections();
    }

    animateStats() {
        const stats = document.querySelectorAll('.stat-number');
        stats.forEach(stat => {
            const finalValue = parseInt(stat.textContent);
            let currentValue = 0;
            const duration = 2000;
            const increment = finalValue / (duration / 16);

            const timer = setInterval(() => {
                currentValue += increment;
                if (currentValue >= finalValue) {
                    stat.textContent = finalValue;
                    clearInterval(timer);
                } else {
                    stat.textContent = Math.round(currentValue);
                }
            }, 16);
        });
    }

    observeSections() {
        const sections = document.querySelectorAll('.section');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, { threshold: 0.1 });

        sections.forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(20px)';
            section.style.transition = 'all 0.6s ease';
            observer.observe(section);
        });
    }
}

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new Dashboard();

    // Add keyboard shortcuts
    document.addEventListener('keydown', (e) => {
        // Ctrl + L for logout
        if (e.ctrlKey && e.key === 'l') {
            e.preventDefault();
            const logoutBtn = document.querySelector('.btn-logout');
            if (logoutBtn) logoutBtn.click();
        }
    });

    // Smooth scrolling for anchor links
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    anchorLinks.forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Utility functions
const utils = {
    formatDate: (date) => {
        return new Date(date).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    },

    formatTime: (date) => {
        return new Date(date).toLocaleTimeString('en-US', {
            hour: '2-digit',
            minute: '2-digit'
        });
    }
};

// EOD Form validation
function validateEODForm() {
    const hours = document.getElementById('<%= txtHoursWorked.ClientID %>');
    const details = document.getElementById('<%= txtWorkDetails.ClientID %>');

    if (!hours.value.trim()) {
        showToast('Please enter hours worked', 'error');
        hours.focus();
        return false;
    }

    if (!details.value.trim()) {
        showToast('Please describe your work', 'error');
        details.focus();
        return false;
    }

    return true;
}

function clearEODForm() {
    document.getElementById('<%= txtHoursWorked.ClientID %>').value = '';
    document.getElementById('<%= txtWorkDetails.ClientID %>').value = '';
    showToast('Form cleared', 'success');
}