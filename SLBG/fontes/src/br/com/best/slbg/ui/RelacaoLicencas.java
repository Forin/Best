/*
 * RelacaoLicencas.java
 *
 * Created on 07/11/2009, 14:51:06
 */
package br.com.best.slbg.ui;

import br.com.best.slbg.bean.Cliente;
import br.com.best.slbg.bean.Licenca;
import br.com.best.slbg.bean.LicencaPK;
import br.com.best.slbg.bo.ClienteBO;
import br.com.best.slbg.util.Utilitario;
import java.util.GregorianCalendar;
import java.util.Vector;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author marcelo
 */
public class RelacaoLicencas extends javax.swing.JInternalFrame {

    // Inicialização da Classe relativa a tabela pai
    private Cliente cliente;
    private ClienteBO clienteBO;
    private Licenca licenca;
    private Utilitario utilitario;

    /** Creates new form RelacaoLicencas */
    public RelacaoLicencas(Cliente cliente) {
        initComponents();
        this.cliente = cliente;
        this.clienteBO = new ClienteBO();
        this.licenca = new Licenca();
        this.utilitario = new Utilitario();
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jbSalvar = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        jtLicenca = new javax.swing.JTable();
        jPanel2 = new javax.swing.JPanel();
        jlContrato = new javax.swing.JLabel();
        jtfNumContrato = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jtfRazaoSocial = new javax.swing.JTextField();

        setClosable(true);
        setIconifiable(true);
        setMaximizable(true);
        setResizable(true);
        setTitle("Relação de Licenças por Máquinas");
        addInternalFrameListener(new javax.swing.event.InternalFrameListener() {
            public void internalFrameActivated(javax.swing.event.InternalFrameEvent evt) {
                formInternalFrameActivated(evt);
            }
            public void internalFrameClosed(javax.swing.event.InternalFrameEvent evt) {
            }
            public void internalFrameClosing(javax.swing.event.InternalFrameEvent evt) {
            }
            public void internalFrameDeactivated(javax.swing.event.InternalFrameEvent evt) {
            }
            public void internalFrameDeiconified(javax.swing.event.InternalFrameEvent evt) {
            }
            public void internalFrameIconified(javax.swing.event.InternalFrameEvent evt) {
            }
            public void internalFrameOpened(javax.swing.event.InternalFrameEvent evt) {
            }
        });

        jPanel1.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jbSalvar.setText("Salvar");
        jbSalvar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jbSalvarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap(470, Short.MAX_VALUE)
                .addComponent(jbSalvar, javax.swing.GroupLayout.PREFERRED_SIZE, 97, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(34, 34, 34))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jbSalvar)
                .addContainerGap())
        );

        jtLicenca.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Id. Servidor", "Qtd. Modeler", "Qtd. Viewer", "Qtd. Meses Renovação"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.Integer.class, java.lang.Integer.class, java.lang.Integer.class
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }
        });
        jtLicenca.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                jtLicencaKeyReleased(evt);
            }
        });
        jScrollPane1.setViewportView(jtLicenca);

        jPanel2.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jlContrato.setText("Núm. Contrato");

        jtfNumContrato.setColumns(20);
        jtfNumContrato.setEditable(false);

        jLabel1.setText("Razão Social");

        jtfRazaoSocial.setEditable(false);

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jtfNumContrato, javax.swing.GroupLayout.PREFERRED_SIZE, 187, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlContrato))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1)
                    .addComponent(jtfRazaoSocial, javax.swing.GroupLayout.DEFAULT_SIZE, 388, Short.MAX_VALUE))
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jlContrato)
                    .addComponent(jLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jtfNumContrato, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jtfRazaoSocial, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 605, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 239, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 29, Short.MAX_VALUE)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void formInternalFrameActivated(javax.swing.event.InternalFrameEvent evt) {//GEN-FIRST:event_formInternalFrameActivated
        // Na Inicialização do Form, capturar o número do contrato e
        // a Razão Social do Cliente para apresenta-lo na tela
        jtfNumContrato.setText(ClienteCad.jtfCodigo.getText());
        jtfRazaoSocial.setText(ClienteCad.jtfNome.getText());

        // Lista as máquinas já armazenadas se as mesmas existirem
        Vector<Licenca> listaMaquinas =
                clienteBO.consultaLicencasPorContrato(jtfNumContrato.getText());

        // Se não existirem máquinas já cadastradas, deve-se incluir as mesmas
        if (listaMaquinas.isEmpty()) {
            for (int i = 1; i <= (Integer) ClienteCad.jsQtdMaquinas.getValue(); i++) {
                utilitario.adicionaLinha(jtLicenca);
            }
        } else {
            //Inclui as máquinas que foram capturadas do banco de dados
            DefaultTableModel modelo = utilitario.retornaModeloTabela(jtLicenca);
            // Carrega as informações vindas do banco e alimenta a jTable
            for (Licenca licencas : listaMaquinas) {
                Vector<Object> colunas = new Vector<Object>();
                colunas.add(licencas.getLicencaPK().getNomeServidor());
                colunas.add(licencas.getQtdModelo());
                colunas.add(licencas.getQtdVisao());
                colunas.add(licencas.getPrazoMesesRenovacao());

                modelo.addRow(colunas);   
            }
        }

    }//GEN-LAST:event_formInternalFrameActivated

    private void jbSalvarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jbSalvarActionPerformed
        // Preciso aqui efetivar o salvamento de ambos os formulários
        // Efetiva a gravação da tabela Cliente
        clienteBO.incluirCliente(cliente);

        // Obtém o objeto 'Modelo' para fazer manutenção no jTable
        DefaultTableModel modelo = utilitario.retornaModeloTabela(jtLicenca);

        // Efetiva a leitura de todas as linhas do jTable
        for (int i = 0; i < modelo.getRowCount(); i++) {

            // Instancia o objeto de chave da  licença
            LicencaPK licencaPK = new LicencaPK(jtLicenca.getValueAt(i, 0).toString().toUpperCase(),
                    cliente.getNumeroContrato());
            // Seta os campos da Licença
            licenca.setLicencaPK(licencaPK);
            licenca.setQtdModelo(jtLicenca.getValueAt(i, 1) == null ? 0 : (Integer) jtLicenca.getValueAt(i, 1));
            licenca.setQtdVisao(jtLicenca.getValueAt(i, 2) == null ? 0 : (Integer) jtLicenca.getValueAt(i, 2));
            licenca.setPrazoMesesRenovacao(jtLicenca.getValueAt(i, 3) == null ? 0 : (Integer) jtLicenca.getValueAt(i, 3));

            // Iniciamos o trabalho sobre os casos de 'Aluguel ou Demonstração"
            if (cliente.getModalidadeVenda().equalsIgnoreCase("A") ||
                    cliente.getModalidadeVenda().equalsIgnoreCase("D")) {
                GregorianCalendar data = new GregorianCalendar();

                if (licenca.getDataProximaRenovacaoAluguel() != null) {
                    data.setTime(licenca.getDataProximaRenovacaoAluguel());
                } else {
                    data.setTime(cliente.getDataVenda());
                }
                data.add(GregorianCalendar.MONTH, licenca.getPrazoMesesRenovacao());
                licenca.setDataProximaRenovacaoAluguel(data.getTime());
            }
            clienteBO.incluirRelacaoLicencas(licenca);
        }
        // Fecha o Form
        this.dispose();
    }//GEN-LAST:event_jbSalvarActionPerformed

    private void jtLicencaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jtLicencaKeyReleased
//        Utilitario.transformaMaicuscula(evt);
    }//GEN-LAST:event_jtLicencaKeyReleased

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JButton jbSalvar;
    private javax.swing.JLabel jlContrato;
    private javax.swing.JTable jtLicenca;
    private javax.swing.JTextField jtfNumContrato;
    private javax.swing.JTextField jtfRazaoSocial;
    // End of variables declaration//GEN-END:variables


}
