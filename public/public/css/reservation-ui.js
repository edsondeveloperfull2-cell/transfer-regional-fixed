// public/js/reservation-ui.js
document.addEventListener('DOMContentLoaded', () => {
  // Quote form
  const quoteForm = document.getElementById('quoteForm');
  const quoteResult = document.getElementById('quoteResult');
  quoteForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const payload = {
      distance_km: Number(form.distance_km.value),
      passengers: Number(form.passengers.value)
    };
    quoteResult.textContent = 'Carregando...';
    try {
      const res = await fetch('/api/quotes', {
        method: 'POST',
        headers: {'Content-Type':'application/json'},
        body: JSON.stringify(payload)
      });
      if (!res.ok) {
        const err = await res.json().catch(()=>({message:'Erro'}));
        throw new Error(err.message || 'Erro ao obter cotação');
      }
      const data = await res.json();
      const amount = (data.amount_cents/100).toFixed(2);
      quoteResult.innerHTML = `Valor: R$ ${amount} <br/>Validade: ${data.expires_at || '60s'}`;
    } catch (err) {
      quoteResult.textContent = 'Erro: ' + err.message;
    }
  });

  // Reservations UI
  const reservationForm = document.getElementById('reservationForm');
  const reservationsList = document.getElementById('reservationsList');

  async function loadReservations() {
    reservationsList.innerHTML = 'Carregando...';
    try {
      const res = await fetch('/api/reservas');
      if (!res.ok) throw new Error('Falha ao carregar reservas');
      const data = await res.json();
      if (!Array.isArray(data) || data.length===0) {
        reservationsList.innerHTML = '<li>Nenhuma reserva.</li>';
        return;
      }
      reservationsList.innerHTML = '';
      data.forEach(r => {
        const li = document.createElement('li');
        li.textContent = `${r.id} — ${r.nome} → ${r.destino} em ${r.data}`;
        reservationsList.appendChild(li);
      });
    } catch (err) {
      reservationsList.innerHTML = '<li>Erro ao carregar reservas</li>';
    }
  }

  reservationForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const payload = {
      nome: form.nome.value,
      destino: form.destino.value,
      data: form.data.value
    };
    try {
      const res = await fetch('/api/reservas', {
        method: 'POST',
        headers: {'Content-Type':'application/json'},
        body: JSON.stringify(payload)
      });
      if (!res.ok) {
        const err = await res.json().catch(()=>({message:'Erro'}));
        throw new Error(err.message || 'Erro ao criar reserva');
      }
      form.reset();
      await loadReservations();
    } catch (err) {
      alert('Erro: ' + err.message);
    }
  });

  // initial load
  loadReservations();
});
