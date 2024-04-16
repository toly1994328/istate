main(){
  S? p = S(null);
  S n = S(null);
  show1(p,n);
}

void show1(S? p, S n){
  if((p?.hasError??true)&&n.hasError){
    print("====n:${n.error}========");
  }
}

void show2(S? p, S n){
  final hasError = (p?.hasError??true)&&n.hasError;
  if(hasError){
    print(n.error);
  }
}

class S{
  final String? error;
  S(this.error);

   bool get hasError => error != null;

}