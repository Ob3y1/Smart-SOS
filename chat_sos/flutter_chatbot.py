from flask import Flask, request, jsonify, session, redirect, url_for,render_template
from flask_cors import CORS
import spacy
from googletrans import Translator  
from flask import Flask, request
import random
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
TYBE5 = []
Infection = []
infection = []
carsmall = []
TYBES=[]
DiceS=[]
translator = Translator()

BOT= False







@app.route('/chat', methods=['POST'])
def chat():
    user_message = request.json.get('message')
    text_ar=user_message
    trans=translator.translate(text_ar,src='ar',dest='en').text
    specific_words_fire = ["extinction","extinguishing","fire", "blaze", "inferno", "flames", "conflagration", "burn", "combustion","explosion","blast","burst"]
    specific_words_police = ["trample","thiev","pirate","urglar","thief","kidnapped","armed","clash","smuggl","terrorist","crime","accident","traffic","ruin","vandalism","sabotage","fray","scrimmage","spat","killer","theft","plagiarism","complaint","fatality", "shooting", "buckshot", "dumdum", "bullet", "gunshot", "blast", "explosion", "burst", "flare","demise","decease", "fate", "dissolution",  "expiry", "endless"]
    specific_words_hospita = ["run over","eye","trample","head","hurts","poisoned","venom","pore","bane","damp","ankle","warp","twist","serious","shock","skin","vein","artery","thrombosis","clot","heart","stroke","suicide","cough","vomi","blood","bleed","person","human","body","confusion","behavior","taste","smell","sight","hear","vision","weak","dizziness","swoon","syncope","fainting","fainted","ache","pain","respiratory","breath","break","stab", "fatality", "injuries","injury", "infection", "hit", "poison","endless", "hospital", "suffocation", "toxicity", "murdered",  "slain", "victim", "hit", "infection", "goal", "cannon"]
    specific_words_diving = ["sink", "drown", "lost","wreck", "deluge", "deep", "sea", "brio", "stream", "wadi", "strand", "chute", "pond",  "flood"]
    specific_words_because_fire = ["leak gas", "gas leak", "gas", "diesel", "gasoline", "kaz", "oil", "kerosene", "blister","circuit"]
    specific_words_death = ["death", "deaths", "demise", "passing", "decease", "fate", "dissolution", "bane", "expiry", "expiration" ,"dead"]
    specific_words_yes =["sur","yes","okay", "yes", "yes","naturally" "Of course", "yes", "really",  "also", "sure","indeed", "exactly", "in fact", "actually", "in fact", "truly", "certainly", "no doubt", "without a doubt", "without a doubt", "without discussion" ,"certainly","definitely","well","well","very","in addition","a lot","directly","almost"]
    specific_words_yes2= ["اكيد","طبعا","بالتأكيد", "نعم", "حسنًا", "نعم", "نعم", "بشكل طبيعي" ,"بالطبع", "نعم", "حقًا", "أيضًا", "بالتأكيد", "في الواقع",  "تماما", "في الواقع", "في الواقع", "في الواقع", "حقا", "بالتأكيد", "بلا شك", "بلا شك", 
                          "بلا شك","مؤكد", "بلا نقاش", "بالتأكيد" ,"بالتأكيد","حسنًا","حسنًا","جدًا","بالإضافة إلى ذلك","كثيرًا","مباشرة","تقريبًا"]
    specific_words_no=["never","no","not at all","not","never"]
    specific_words_no2=["أبدًا", "لا", "ليس على الإطلاق", "لا", "أبدًا","مستحيل","كلا","لايوجد", "لا يوجد", "لااعتقد"]
    specific_words_dontknow=["no know","know","maybe","possible"]
    specific_words_dontknow=["لااعلم"]
    specific_words_person=["boy","girl","man","woman","child"]
    greetings = ["أهلاً", "مرحبا", "السلام عليكم", "صباح الخير", "مساء الخير", "أهلاً وسهلاً", "كيف حالك؟", "تشرفت بلقائك"]
    greetings2 =[ "مرحبًا بك، كيف يمكنني مساعدتك اليوم؟",
 "أهلاً وسهلاً، ما هي المشكلة التي تواجهها؟",
 "مرحبًا، يُرجى إخباري بمشكلتك لنتمكن من مساعدتك.",

 "مرحبًا، كيف يمكنني تقديم الدعم لك؟",
 "أهلاً، يُرجى مشاركة مشكلتك معنا.",
 "مرحبًا بك، نحن هنا للاستماع إليك، فما هي مشكلتك؟",
 "أهلاً وسهلاً، كيف يمكنني مساعدتك في حل مشكلتك؟",
 "مرحبًا، يُرجى إخباري بما يزعجك لنساعدك.",
 "أهلاً بك، ما هي الأمور التي تحتاج إلى مساعدة فيها؟"]
    specific_words_problme=[ "من فضلك، حدد طبيعة المشكلة.",
" هل يمكنك توضيح نوع المشكلة التي تواجهها؟", " أرجو منك تحديد نوع المشكلة بشكل دقيق",
" يرجى توضيح نوع المشكلة التي تحتاج إلى مساعدة بشأنها.",
" هل يمكنك تحديد المشكلة التي تريد ان تبلغ عنها؟"
,"من فضلك حدد نوع المشكلة"]
    specific_q_street=[" هل تتواجد في شارع واسع؟",
" هل أنت في طريق رئيسي؟"," هل أنت في شارع عريض؟",
"هل أنت في منطقة شوارع كبيرة؟",
 "هل أنت في شارع كبير الحجم؟"]
    specific_q_inf=[" هل وقع أي ضرر للأشخاص؟",
 " هل تعرض أحد للإصابة؟" ,"هل هناك أي اصابات بين البشر؟", "هل أصيب أي شخص؟",
" هل حدثت إصابات بين الأفراد؟"]
    q_inf = random.choice(specific_q_inf)
    Q_street = random.choice(specific_q_street)
    problme = random.choice(specific_words_problme)
    doc=nlp(trans)







    for token in doc:
        if  user_message in greetings:
          bot_response = "اهلا بك   اخبرنا بمشكلتك من فضلك"
          
          return jsonify({'response': bot_response}) 
            
    
 
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_fire or user_message == "الاطفاء":
                if not TYBE1:
                    TYBE1.append("1.")
                    TYBE1S=''.join(TYBE1)
                    TYBE.append(TYBE1S)
                     
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_police:
                if not TYBE2:
                    TYBE2.append("2.")
                    TYBE2S=''.join(TYBE2)
                    TYBE.append(TYBE2S)  
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_diving:
                if not TYBE3:
                    TYBE3.append("3.")
                    TYBE3S=''.join(TYBE3)
                    TYBE.append(TYBE3S)
                    TYBE4.append("4.")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)
                    infection.append(lemma)
                    infectionS=''.join(infection)
                    Dice.append(infectionS)
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_hospita:
                if not TYBE4:
                    TYBE4.append("4.")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)  
                    infection.append(lemma)
                    infectionS=''.join(infection)
                    Dice.append(infectionS) 
                         
    for entity2 in doc:
            lemma = entity2.lemma_
            if lemma in specific_words_death:
                if not TYBE5:
                    TYBE5.append("2.4")
                    TYBE5S=''.join(TYBE5)
                    TYBE.append(TYBE5S)
    for token in doc:
         lemma = token.lemma_
         if token.text =="run" and token.i < len(doc) -1 and doc[token.i+1].text == "over" :     
              if not TYBE5:
                    TYBE5.append("2.4")
                    TYBE5S=''.join(TYBE5)
                    TYBE.append(TYBE5S)
                    Dice.append("RUN OVER") 
    for token in doc:
         lemma = token.lemma_
         if token.text =="of" and token.i < len(doc) -1 and doc[token.i+1].text == "course" :     
              if not TYBE5:
                    TYBE5.append("2.4")
                    TYBE5S=''.join(TYBE5)
                    TYBE.append(TYBE5S)
                    Dice.append("RUN OVER") 

    for token in doc:
         lemma = token.lemma_

         if len(doc) > 2:
          if token.text =="no" and token.i < len(doc) -1 and doc[token.i+1].text == "know" :     
              if not TYBE5:
                  user_message =" نعم "
                  TYBE4.append("4.")
                  TYBE4S=''.join(TYBE4)
                  infection.append(user_message)
                  infectionS="".join(infection)
                  Dice.append(infectionS)
                  DiceS=''.join(Dice)
            
          

                  bot_response = Q_street
                  carsmall.append(" سيارة صغيرة  : ")
                  return jsonify({'response': bot_response})    
    for token in doc :
      lemma = token.lemma_
      if token.pos_ == "PROPN":
            if not TYBE4:
                    TYBE4.append("4.")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)  
                    infection.append("person")
                    infectionS=''.join(infection)
                    Dice.append(infectionS) 
    for token in doc :
      lemma = token.lemma_
      if  token.dep_ =='nsubjpass':
            if not TYBE4:
                    TYBE4.append("4.")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)  
                    infection.append(token.text)
                    infectionS=''.join(infection)
                    Dice.append(infectionS)                

                                                  
    for token in doc :
      lemma = token.lemma_
      if token.pos_ == "NOUN" and token.text in specific_words_person:
            if not TYBE4:
                    TYBE4.append("4.")
                    TYBE4S=''.join(TYBE4)
                    TYBE.append(TYBE4S)  
                    infection.append("person")
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
        bot_response = q_inf 
        infection.append(",الاصابة:")
        
        return jsonify({'response': bot_response})
      elif not carsmall:
             

             for entity in doc: 
              lemma = entity.lemma_
              if lemma in specific_words_yes or user_message in specific_words_yes2 or lemma in specific_words_dontknow or user_message == "لااعلم": 
                  user_message =" نعم "
                  TYBE4.append("4")
                  TYBE4S=''.join(TYBE4)
                  TYBE.append(TYBE4S)
                  infection.append(user_message)
                  infectionS="".join(infection)
                  Dice.append(infectionS)
                  DiceS=''.join(Dice)
            
          

                  bot_response = Q_street
                  carsmall.append(" سيارة صغيرة  : ")
                  return jsonify({'response': bot_response})
              elif lemma in specific_words_no or user_message in specific_words_no2:
                      
                 user_message =" لا ,"
            
                 infection.append(user_message)
                 infectionS="".join(infection)
                 Dice.append(infectionS)
                 DiceS=''.join(Dice)
           
                 bot_response = Q_street
                 carsmall.append(",carsmall:")
                 return jsonify({'response': bot_response}) 
              
                   
              else: 
               bot_response = f"اجب بنعم او لا من فضلك"  
               return jsonify({'response': bot_response}) 
                   
            
      elif carsmall :
           for entity in doc:
              lemma2 = entity.lemma_ 
              if lemma in specific_words_yes or user_message in specific_words_yes2: 
                    bot_response = f"  لا تقلق نحن قادمون"  
                    user_message = " لا"
                    carsmall.append(user_message)
                    carsmallS="".join(carsmall)
                    Dice.append(carsmallS)
                    DiceS=''.join(Dice)
                    return jsonify({'response': bot_response})
               

# الشرط الثاني: تحقق من وجود `lemma` في المصفوفة الثانية
              elif lemma2 in specific_words_no:
                    bot_response = f"  لا تقلق نحن قادمون"  
                    user_message = "نعم"
                    carsmall.append(user_message)
                    carsmallS="".join(carsmall)
                    Dice.append(carsmallS)
                    DiceS=''.join(Dice)
                    return jsonify({'response': bot_response})
               

# الشرط الثالث: إذا لم يتحقق أي من الشرطين السابقين
              else :
                   bot_response = f"اجب بنعم او لا من فضلك"  
                   return jsonify({'response': bot_response})

            

             
    elif TYBE2:
         infection2=False
         if not infection :
           
           
           bot_response = q_inf 
           infection.append(",infenction:")
           infection2==True
        
           return jsonify({'response': bot_response})
         for entity in doc: 
              lemma = entity.lemma_
              if lemma in specific_words_yes or user_message in specific_words_yes2 or lemma in specific_words_dontknow or user_message == "لااعلم": 
                  user_message =" نعم "
                  TYBE4.append("4.")
                  TYBE4S=''.join(TYBE4)
                  TYBE.append(TYBE4S)
                  infection.append(user_message)
                  infectionS="".join(infection)
                  Dice.append(infectionS)
                  DiceS=''.join(Dice)
            
          

                  bot_response = f"لا تقلق نحن قادمون"  
                  carsmall.append(" سيارة صغيرة  : ")
                  return jsonify({'response': bot_response})
              elif lemma in specific_words_no or user_message in specific_words_no2:
                      
                 user_message =" لا ,"
            
                 infection.append(user_message)
                 infectionS="".join(infection)
                 Dice.append(infectionS)
                 DiceS=''.join(Dice)
           
                 bot_response = f"لا تقلق نحن قادمون"   
                 carsmall.append(",carsmall:")
                 return jsonify({'response': bot_response}) 
              
                   
              else: 
               bot_response = f"اجب بنعم او لا من فضلك"  
               return jsonify({'response': bot_response}) 
         





 





  
           
    elif TYBE3:
              
           BOT=True
           bot_response = f"لا تقلق نحن قادمون"  
           return jsonify({'response': bot_response})     
    elif TYBE4:
              
           BOT=True
           bot_response = f"لا تقلق نحن قادمون"  
           return jsonify({'response': bot_response})     
    elif TYBE5:
              
           BOT=True
           bot_response = f"لا تقلق نحن قادمون"  
           return jsonify({'response': bot_response})     
         
    else:   
         
         bot_response =problme
         return jsonify({'response': bot_response})




@app.route('/get_data', methods=['GET'])
def get_data():
    Di = "".join(Dice)
    TY = "".join(TYBE)
    clear = True
    
    if Di and TY:
        if clear:
             clear = False
             
             Dice.clear()  # Reset Dice
             TYBE.clear()  
             TYBE1.clear()
             TYBE2.clear()
             TYBE3.clear()
             TYBE4.clear()
             TYBE5.clear()
             Infection.clear()
             infection.clear()
             carsmall.clear()
             TYBES.clear()
             DiceS.clear()
             numbers.clear()
             Dice.clear()
             numbers.clear()
             PLACE.clear()
             DEGREE_OF_RISK.clear()
             NUM_OF_DEATH.clear()
             CAUSE_OF_CONDITION.clear()

            # Optionally, you can reset Dice and TYBE here
          # Reset TYBE
             return jsonify({'greetings': TY, 'greetings2': Di})
        
    else:
        return jsonify({'greetings': 'لايوجد', 'greetings2': 'لا يوجد'})
 

if __name__ == '__main__':
     app.run(debug=True)   
    
