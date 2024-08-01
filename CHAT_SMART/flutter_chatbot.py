from flask import Flask, request, jsonify, session, redirect, url_for
from flask_cors import CORS
import spacy
from googletrans import Translator  
app = Flask(__name__)
CORS(app)
nlp = spacy.load("en_core_web_sm") 
numbers=[]
Dice=[]
numbers = []
PLACE = []
DEGREE_OF_RISK = []
NUM_OF_DEATH = []
CAUSE_OF_CONDITION = []
TYBE = []
TYBE1 = []
TYBE2 = []
TYBE3 = []
TYBE4 = []
Infection = []
infection = []
carsmall = []
TYBES=[]
DiceS=[]
translator = Translator()









@app.route('/chat', methods=['POST'])
def chat():
    user_message = request.json.get('message')
    text_ar=user_message
    trans=translator.translate(text_ar,src='ar',dest='en').text
    specific_words_fire = ["fire", "blaze", "inferno", "flames", "conflagration", "burn", "combustion"]
    specific_words_police = ["dead","fatality", "shooting", "buckshot", "dumdum", "bullet", "gunshot", "blast", "explosion", "burst", "flare", "killing", "death", "demise", "passing", "decease", "fate", "dissolution", "bane", "expiry", "expiration", "endless"]
    specific_words_hospita = ["stab", "fatality", "injuries", "infection", "hit", "poison", "death", "demise", "passing", "decease", "fate", "dissolution", "bane", "expiry", "expiration", "endless", "hospital", "suffocation", "toxicity", "murdered", "dead", "slain", "victim", "hit", "infection", "goal", "cannon"]
    specific_words_diving = ["sink", "drown", "wreck", "deluge", "deep", "sea", "brio", "stream", "wadi", "strand", "chute", "pond",  "flood"]
    specific_words_because_fire = ["leak gas", "gas leak", "gas", "diesel", "gasoline", "kaz", "oil", "kerosene", "blister"]
    specific_words_death = ["death", "deaths", "demise", "passing", "decease", "fate", "dissolution", "bane", "expiry", "expiration"]
    
    doc=nlp(trans)
 
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_fire:
                if not TYBE1:
                    TYBE1.append("1,")
                    TYBE1S=''.join(TYBE1)
                    TYBE.append(TYBE1S)
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_police:
                if not TYBE2:
                    TYBE2.append("2,")
                    TYBE2S=''.join(TYBE2)
                    TYBE.append(TYBE2S)  
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_diving:
                if not TYBE3:
                    TYBE3.append("3,")
                    TYBE3S=''.join(TYBE3)
                    TYBE.append(TYBE3S)
                    TYBE4.append("4,")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)
                    infection.append(lemma)
                    infectionS=''.join(infection)
                    Dice.append(infectionS)
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_hospita:
                if not TYBE4:
                    TYBE4.append("4,")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)  
                    infection.append(lemma)
                    infectionS=''.join(infection)
                    Dice.append(infectionS)                                                
 

    for toknum in doc:
            if toknum.like_num and len(toknum.text) >= 10:
                numbers.append(toknum.text)
                numbersS=''.join(numbers)
                Dice.append(numbersS)
    

    for entity in doc.ents:
            if entity.label_ == "GPE":  # GPE refers to geopolitical entity (countries, cities, states)
                PLACE.append(entity.text)     
                PLACES="".join(PLACE)
                Dice.append(PLACES)  
    for becu in doc:
            lemma = becu.lemma_
            if lemma in specific_words_because_fire:
                CAUSE_OF_CONDITION.append(lemma)   
                CAUSE_OF_CONDITIONS="".join(CAUSE_OF_CONDITION)
                Dice.append(CAUSE_OF_CONDITIONS) 

    for i, death_token in enumerate(doc):
            lemma = death_token.lemma_
            if lemma in specific_words_death and i < len(doc):
                DEGREE_OF_RISK.append(lemma)
                DEGREE_OF_RISKS="".join(DEGREE_OF_RISK)
                Dice.append(DEGREE_OF_RISKS)
                for j in range(i + 1, len(doc)):
                    if doc[j].pos_ == "NUM" and len(doc[j].text) < 3:
                        NUM_OF_DEATH.append(doc[j].text)
                        NUM_OF_DEATH_S=''.join(NUM_OF_DEATH)
                        Dice.append(NUM_OF_DEATH_S)
                    else:
                        for num_death in death_token.lefts:
                            if num_death.pos_ == "NUM":
                                NUM_OF_DEATH.append(num_death.text)
                                NUM_OF_DEATH_S=''.join(NUM_OF_DEATH)
                                Dice.append(NUM_OF_DEATH_S)

    DiceS=''.join(Dice)
    TYBES=''.join(TYBE)
    qu=1
                
    # هنا يمكنك إضافة منطق معالجة الرسالة
    
    if TYBE1 :
      if not infection :
       if not carsmall: 
        
            #else : bot_response = f"انت قلت: لا يوجد رقم"
        qu=qu+1
        bot_response = f"هل هناك اصابات بشرية؟!:"  
        infection.append(",الاصابة:")
        
        return jsonify({'response': bot_response})
      elif not carsmall:
           if user_message == "نعم" :
            user_message ==", نعم"
            TYBE4.append("4,")
            TYBE4S=''.join(TYBE4)
            TYBE.append(TYBE4S) 
            infection.append(user_message)
            infectionS="".join(infection)
            Dice.append(infectionS)
            DiceS=''.join(Dice)
           
            bot_response = f"هل انت في شارع كبير؟؟!:"  
            carsmall.append(" سيارة صغيرة  : ")
            return jsonify({'response': bot_response})
           elif user_message == "لا" :
             
               user_message ==" لا ,"
            
               infection.append(user_message)
               infectionS="".join(infection)
               Dice.append(infectionS)
               DiceS=''.join(Dice)
           
               bot_response = f"هل انت في شارع كبير؟؟!:"  
               carsmall.append(",carsmall:")
               return jsonify({'response': bot_response}) 
      elif carsmall : 
            if user_message == "نعم" or user_message =="لا":
              user_message == " لا,"
              carsmall.append(user_message)
              carsmallS="".join(carsmall)
              Dice.append(carsmallS)
              DiceS=''.join(Dice)
           
              bot_response = f"لا تقلق نحن قادمون:"  
              return jsonify({'response': bot_response})
            elif  user_message =="لا":
              user_message == " نعم , "
              carsmall.append(user_message)
              carsmallS="".join(carsmall)
              Dice.append(carsmallS)
              DiceS=''.join(Dice)
              get_data()
           
              bot_response = f"لا تقلق نحن قادمون"  
              return jsonify({'response': bot_response})
    elif TYBE2:
         if not infection :
           bot_response = f"هل هناك اصابات بشرية؟!:"  
           infection.append(",infenction:")
        
           return jsonify({'response': bot_response})
         elif infection:
            if user_message == "نعم" :
              user_message ==", نعم"
              TYBE4.append(" 4 ,")
              TYBE4S=''.join(TYBE4)
              TYBE.append(TYBE4S) 
            
              infection.append(user_message)
              infectionS="".join(infection)
              Dice.append(infectionS)
              DiceS=''.join(Dice)
            elif user_message == "لا" :
              user_message ==", لا"
            
              infection.append(user_message)
              infectionS="".join(infection)
              Dice.append(infectionS)
              DiceS=''.join(Dice)  
           
            bot_response = f"لا تقلق نحن قادمون"  
            return jsonify({'response': bot_response})
                 
            
    elif  TYBE4 :
          bot_response = f"لا تقلق نحن قادمون"  
          return jsonify({'response': bot_response})
    elif  TYBE3 and TYBE4 :
          bot_response = f"لا تقلق نحن قادمون"  
          return jsonify({'response': bot_response})
         
    else:      
         bot_response ="من فضلك حدد نوع المشكلة"
         return jsonify({'response': bot_response})
     
    

@app.route('/get_data', methods=['GET'])


                                                       
def get_data():
 

    Di="".join(Dice)
    TY="".join(TYBE)
    if Di and TY:
     text_ar=Di
     trans=translator.translate(text_ar,src='en',dest='ar').text
     Dic="".join(trans)
  
     return jsonify({'greetings': TY,'greetings2': Di})
    else :
        Di.append("لا يوجد")
        di2="".join(Di)
        TY.append("لا يوجد")
        TY2="".join(TY)
        return jsonify({'greetings': TY2,'greetings2': di2})

if __name__ == '__main__':
     app.run(debug=True)   
    
