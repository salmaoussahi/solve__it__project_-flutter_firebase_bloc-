import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfirebase/bloc/commentaire/commentaire_bloc.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';

class Commenter extends StatelessWidget {
  String problemId;
  Commenter({Key? key, required this.problemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _commentaire = new TextEditingController();

    void _addComment(BuildContext context) {
      BlocProvider.of<CommentaireBloc>(context).add(
        AddCommentRequested(
            commentaire: _commentaire.text, problemId: this.problemId),
      );
    }

    return BlocConsumer<CommentaireBloc, CommentaireState>(
      builder: (context, state) {
        if (state is LodingAddComment) {
          return  Center(child: CircularProgressIndicator(color: Palette.yellow,));
        }
        return AlertDialog(
          title: Text('Ajouter un commentaire'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                cursorColor: Colors.grey,
                controller: _commentaire,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Entrer votre Commentaire ici",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Annuler'),
              child: Text('Cancel',style: TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: () => {_addComment(context), print(_commentaire.text)},
              child: Text(
                'Ajouter',
                style: TextStyle(color: Palette.yellow),
              ),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is LoadedAddComment) {
          BlocProvider.of<CommentaireBloc>(context)
        .add(ProblemCommentsRequested(problemId: this.problemId));
          Navigator.of(context).pop();
        }
        if (state is ErrorAddComment) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errormessage)));
        }
      },
    );
  }
}
