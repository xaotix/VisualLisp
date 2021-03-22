
void IExtensionApplication.Initialize()
        {
            Application.DocumentManager.DocumentBecameCurrent += new DocumentCollectionEventHandler(docColDocAct);

            //RunTest();
        }

        void IExtensionApplication.Terminate()
        {
            
        }

        /// <summary>
        /// Evento que monitora quando um documento está em modo atual
        /// </summary>
        /// <param name="senderObj"></param>
        /// <param name="docColDocActEvtArgs"></param>
        public void docColDocAct(object senderObj, DocumentCollectionEventArgs docColDocActEvtArgs)
        {
            ReturnLastSelection.AddDocEventStart();
        }

        #region Area de Teste
        [CommandMethod("MONITORAR")]
        public void MonitorarRotinas()
        {
            Document doc = AppAutocad.DocumentManager.MdiActiveDocument;
            //Database data = doc.Database;
            var editor = doc.Editor;
            doc.CommandEnded += new CommandEventHandler(CapturarEventoFinalizado);
            doc.CommandWillStart += new CommandEventHandler(CapturarEventoIniciado);
        }

        static List<string> NomeFuncoes = new List<string>();

        static void CapturarEventoFinalizado(object e, CommandEventArgs eventArgs)
        {
            NomeFuncoes.Add(eventArgs.GlobalCommandName);

            Document doc = AppAutocad.DocumentManager.MdiActiveDocument;
            //Database data = doc.Database;
            var editor = doc.Editor;

            if (eventArgs.GlobalCommandName == "UCS")
            {
                //Autodesk
                //NomeFuncoes.Add();
            }

        }

        static void CapturarEventoIniciado(object e, CommandEventArgs eventArgs)
        {


        }

        [CommandMethod("SALVARLOG")]
        public void SalvarLog()
        {
            File.WriteAllLines(@"C: \Users\richard\Documents\Log Autocad.txt", NomeFuncoes.ToArray());

            NomeFuncoes.Clear();

            Document doc = AppAutocad.DocumentManager.MdiActiveDocument;
            //Database data = doc.Database;
            var editor = doc.Editor;
            doc.CommandEnded -= new CommandEventHandler(CapturarEventoFinalizado);
        }
        #region Evento Objeto Adicionado a DataBase
        static public void RunTest()
        {
            Document doc = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument;
            Editor ed = doc.Editor;
            Database db = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument.Database;
            db.ObjectAppended += new ObjectEventHandler(Database_ObjectAppended);
        }
        static void Database_ObjectAppended(object sender, ObjectEventArgs e)
        {
            Document doc = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument;
            Database db = doc.Database;
            Editor ed = doc.Editor;
            DBObject dbObj = e.DBObject;
            using (Transaction tr = db.TransactionManager.StartTransaction())
            {
                Object pOwner = tr.GetObject(dbObj.OwnerId, OpenMode.ForRead);

                AppAutocad.ShowAlertDialog(string.Format("Nome do Objeto: {0}, ID: {1}", e.DBObject.GetType().ToString(), dbObj.OwnerId.ToString()));
                //if (dbObj.IsReadEnabled)
                //{
                //    //Circle pCir = dbObj as Circle; //check confined only to circle 
                //    if (pCir != null)
                //    {
                        
                //        //BlockTableRecord btr = pOwner as BlockTableRecord;
                //        //if (btr != null)
                //        //{
                //        //    ed.WriteMessage("the Block table name is : " + btr.Name + "\n");
                //        //}
                //    }
                //}
                tr.Commit();
            }
        }
        #endregion

        #endregion