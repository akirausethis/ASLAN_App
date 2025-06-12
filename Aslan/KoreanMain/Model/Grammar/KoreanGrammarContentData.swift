// AslanApp/Model/Grammar/KoreanGrammarContentData.swift
import Foundation

struct KoreanGrammarContentData {

    static let allMaterials: [GrammarMaterial] = [
        // --- Materi untuk "Basic Particles" (diselaraskan dengan KoreanGrammarListView) ---
        GrammarMaterial(
            courseTitle: "Basic Particles", // Diselaraskan
            topicTitle: "Particles 은/는 (eun/neun) - Topic Marker",
            explanation: """
            Particles 은 (eun) and 는 (neun) are topic markers. They indicate what the sentence is about, similar to Japanese は (wa).
            은 (eun) is used after a noun ending in a consonant.
            는 (neun) is used after a noun ending in a vowel.
            They set the stage, saying "As for..." or "Speaking of...".
            """,
            examples: [
                ExampleSentence(japanese: "저는 학생입니다.", romaji: "Jeo-neun haksaeng-imnida.", english: "I am a student. (As for me...)"),
                ExampleSentence(japanese: "이것은 책입니다.", romaji: "Igeot-eun chaek-imnida.", english: "This is a book."),
                ExampleSentence(japanese: "오늘은 날씨가 좋습니다.", romaji: "Oneul-eun nalssi-ga jotseumnida.", english: "Today, the weather is good.")
            ],
            tip: "Think of 은/는 as highlighting the main character of your sentence's story."
        ),
        GrammarMaterial(
            courseTitle: "Basic Particles", // Diselaraskan
            topicTitle: "Particles 이/가 (i/ga) - Subject Marker",
            explanation: """
            Particles 이 (i) and 가 (ga) are subject markers, similar to Japanese が (ga). They often identify the subject performing an action or being described, especially when introducing new information.
            이 (i) is used after a noun ending in a consonant.
            가 (ga) is used after a noun ending in a vowel.
            """,
            examples: [
                ExampleSentence(japanese: "고양이가 있습니다.", romaji: "Goyangi-ga itseumnida.", english: "There is a cat."),
                ExampleSentence(japanese: "누가 왔습니까?", romaji: "Nuga watsseumnikka?", english: "Who came?"),
                ExampleSentence(japanese: "이 사과가 맛있습니다.", romaji: "I sagwa-ga masitseumnida.", english: "This apple is delicious.")
            ],
            tip: "이/가 often answers the 'who' or 'what' question about the verb."
        ),
         GrammarMaterial(
            courseTitle: "Basic Particles", // Diselaraskan
            topicTitle: "Particles 을/를 (eul/reul) - Object Marker",
            explanation: """
            Particles 을 (eul) and 를 (reul) mark the direct object of a verb, similar to Japanese を (o). They show what receives the action.
            을 (eul) is used after a noun ending in a consonant.
            를 (reul) is used after a noun ending in a vowel.
            """,
            examples: [
                ExampleSentence(japanese: "빵을 먹습니다.", romaji: "Ppang-eul meokseumnida.", english: "I eat bread."),
                ExampleSentence(japanese: "물을 마십니다.", romaji: "Mul-eul masimnida.", english: "I drink water."),
                ExampleSentence(japanese: "책을 읽습니다.", romaji: "Chaek-eul ikseumnida.", english: "I read a book.")
            ],
            tip: "Look for 을/를 after the noun being acted upon."
        ),

        // --- Materi untuk "Verb Conjugation" (diselaraskan dengan KoreanGrammarListView) ---
        GrammarMaterial(
            courseTitle: "Verb Conjugation", // Diselaraskan
            topicTitle: "Present Tense (ㅂ니다/습니다 -mnida/seumnida)",
            explanation: """
            The -ㅂ니다/습니다 (-mnida/seumnida) form is a formal, polite way to end verbs in the present tense in Korean. It's often used in formal presentations, news broadcasts, and the military, but also in polite initial interactions.
            -ㅂ니다 is added to verb stems ending in a vowel.
            -습니다 is added to verb stems ending in a consonant.
            """,
            examples: [
                ExampleSentence(japanese: "먹습니다 (먹다)", romaji: "meokseumnida (meokda)", english: "to eat (formal polite)"),
                ExampleSentence(japanese: "마십니다 (마시다)", romaji: "masimnida (masida)", english: "to drink (formal polite)"),
                ExampleSentence(japanese: "갑니다 (가다)", romaji: "gamnida (gada)", english: "to go (formal polite)"),
                ExampleSentence(japanese: "봅니다 (보다)", romaji: "bomnida (boda)", english: "to see/watch (formal polite)")
            ],
            tip: "This form is very polite but less common in everyday casual conversation than the -아요/어요 (-ayo/eoyo) form."
        ),

        // --- Materi untuk "Sentence Structure" (diselaraskan dengan KoreanGrammarListView) ---
        GrammarMaterial(
            courseTitle: "Sentence Structure", // Diselaraskan
            topicTitle: "Basic Order: Subject-Object-Verb (SOV)",
            explanation: """
            Similar to Japanese, the basic Korean sentence structure is Subject-Object-Verb (SOV).
            Particles mark the function of each noun (e.g., 은/는 for topic, 이/가 for subject, 을/를 for object).
            """,
            examples: [
                ExampleSentence(japanese: "저는 빵을 먹습니다.", romaji: "Jeo (S) -neun ppang (O) -eul meokseumnida (V).", english: "I eat bread."),
                ExampleSentence(japanese: "고양이가 생선을 봅니다.", romaji: "Goyangi (S) -ga saengseon (O) -eul bomnida (V).", english: "The cat watches the fish."),
                ExampleSentence(japanese: "김 씨는 책을 읽었습니다.", romaji: "Gim ssi (S) -neun chaek (O) -eul ilgeotsseumnida (V).", english: "Mr. Kim read a book.")
            ],
            tip: "The verb always comes last in a basic Korean sentence!"
        ),
         GrammarMaterial(
            courseTitle: "Sentence Structure", // Diselaraskan
            topicTitle: "Adding 까 (kka) for Questions",
            explanation: """
            To turn a formal declarative sentence (ending in -ㅂ니다/습니다) into a question, you change the ending to -ㅂ니까/습니까 (-mnikka/seumnikka).
            The word order generally remains the same.
            """,
            examples: [
                ExampleSentence(japanese: "이것은 책입니까?", romaji: "Igeot-eun chaegimnikka?", english: "Is this a book?"),
                ExampleSentence(japanese: "빵을 먹습니까?", romaji: "Ppang-eul meokseumnikka?", english: "Do you eat bread?"),
                ExampleSentence(japanese: "안녕하십니까?", romaji: "Annyeonghasimnikka?", english: "How are you? / Hello (Formal)")
            ],
            tip: "Just change 다 (da) to 까 (kka) at the end for formal questions."
        ),

        // MARK: - Intermediate Grammar Materials
        GrammarMaterial(
            courseTitle: "Advanced Particles", // Diselaraskan
            topicTitle: "Particles 에 (e) and 에서 (eseo) - Location Markers",
            explanation: """
            에 (e) is used to indicate a destination, a time, or a static location where something exists.
            에서 (eseo) is used to indicate the location where an action takes place, or the starting point of an action.
            """,
            examples: [
                ExampleSentence(japanese: "학교에 가요.", romaji: "Hakgyo-e gayo.", english: "I go to school."),
                ExampleSentence(japanese: "집에 있어요.", romaji: "Jib-e isseoyo.", english: "I am at home."),
                ExampleSentence(japanese: "학교에서 공부해요.", romaji: "Hakgyo-eseo gongbuhaeyo.", english: "I study at school."),
                ExampleSentence(japanese: "서울에서 왔어요.", romaji: "Seoul-eseo wasseoyo.", english: "I came from Seoul.")
            ],
            tip: "에 is for 'to/at' (existence), 에서 is for 'at/from' (action/origin)."
        ),
        GrammarMaterial(
            courseTitle: "Advanced Particles", // Diselaraskan
            topicTitle: "Particles 도 (do) - 'Also' / 'Too'",
            explanation: """
            도 (do) is added to a noun or pronoun to mean 'also' or 'too'. It replaces topic particles (은/는) or subject/object particles (이/가, 을/를) if they would normally be used.
            """,
            examples: [
                ExampleSentence(japanese: "저도 학생입니다.", romaji: "Jeo-do haksaeng-imnida.", english: "I am also a student."),
                ExampleSentence(japanese: "이것도 책입니다.", romaji: "Igeot-do chaek-imnida.", english: "This is also a book."),
                ExampleSentence(japanese: "밥도 먹었어요.", romaji: "Bap-do meogeosseoyo.", english: "I also ate rice.")
            ],
            tip: "도 attaches directly to the noun, swallowing other particles."
        ),
        GrammarMaterial(
            courseTitle: "Advanced Particles", // Diselaraskan
            topicTitle: "Particle 와/과 (wa/gwa) - 'And' / 'With'",
            explanation: """
            와 (wa) and 과 (gwa) are used to connect two nouns meaning 'and' or 'with'.
            와 (wa) is used after a noun ending in a vowel.
            과 (gwa) is used after a noun ending in a consonant.
            """,
            examples: [
                ExampleSentence(japanese: "친구와 영화를 봤어요.", romaji: "Chingu-wa yeonghwa-reul bwasseoyo.", english: "I watched a movie with a friend."),
                ExampleSentence(japanese: "빵과 우유.", romaji: "Ppang-gwa uyu.", english: "Bread and milk."),
                ExampleSentence(japanese: "사과와 바나나.", romaji: "Sagwa-wa banana.", english: "Apple and banana.")
            ],
            tip: "Think of them as a 'connector' for nouns."
        ),

        GrammarMaterial(
            courseTitle: "Conditional Forms", // Diselaraskan
            topicTitle: "-(으)면 (-eun/myeon) - If / When",
            explanation: """
            This ending is attached to a verb or adjective stem to express a conditional meaning ('if' or 'when').
            -으면 is used after a stem ending in a consonant.
            -면 is used after a stem ending in a vowel or 'ㄹ' (rieul).
            """,
            examples: [
                ExampleSentence(japanese: "비가 오면 집에 있을 거예요.", romaji: "Bi-ga o-myeon jib-e isseul geoyeyo.", english: "If it rains, I will stay home."),
                ExampleSentence(japanese: "책을 읽으면 재미있어요.", romaji: "Chaek-eul ilg-eumyeon jaemiisseoyo.", english: "If I read a book, it's fun."),
                ExampleSentence(japanese: "배고프면 드세요.", romaji: "Baegopeu-myeon deuseyo.", english: "If you're hungry, please eat.")
            ],
            tip: "This is a versatile 'if' statement for Korean."
        ),
        GrammarMaterial(
            courseTitle: "Conditional Forms", // Diselaraskan
            topicTitle: "-(으)려면 (-eu/ryeomyeon) - If you want to / In order to",
            explanation: """
            This ending means 'if you want to' or 'in order to' and indicates a purpose or intention.
            -으려면 is used after a stem ending in a consonant.
            -려면 is used after a stem ending in a vowel.
            """,
            examples: [
                ExampleSentence(japanese: "한국어를 배우려면 열심히 공부해야 해요.", romaji: "Hanguk-eo-reul baeu-ryeomyeon yeolsimhi gongbuhaeya haeyo.", english: "If you want to learn Korean, you have to study hard."),
                ExampleSentence(japanese: "돈을 벌려면 일해야 해요.", romaji: "Don-eul beol-ryeomyeon ilhaeya haeyo.", english: "In order to earn money, I have to work."),
                ExampleSentence(japanese: "밥을 먹으려면 식당에 가세요.", romaji: "Bap-eul meog-euryeomyeon sikdang-e gaseyo.", english: "If you want to eat, go to a restaurant.")
            ],
            tip: "Use this to express a prerequisite for a goal."
        ),
        GrammarMaterial(
            courseTitle: "Conditional Forms", // Diselaraskan
            topicTitle: "-(으)니까 (-eu/nikka) - So / Because (reason)",
            explanation: """
            This ending is used to express a reason or cause for the following action or state, often implying that the speaker knows the listener also knows or will understand the reason.
            -으니까 is used after a stem ending in a consonant.
            -니까 is used after a stem ending in a vowel or 'ㄹ' (rieul).
            """,
            examples: [
                ExampleSentence(japanese: "비가 오니까 우산이 필요해요.", romaji: "Bi-ga o-nikka usan-i piryohaeyo.", english: "It's raining, so I need an umbrella."),
                ExampleSentence(japanese: "바쁘니까 다음에 만나요.", romaji: "Bappeun-ikka daeum-e mannayo.", english: "I'm busy, so let's meet next time."),
                ExampleSentence(japanese: "지금 가니까 도착할 거예요.", romaji: "Jigeum ga-nikka dochakhal geoyeyo.", english: "I'm leaving now, so I'll arrive.")
            ],
            tip: "Often used when the reason is obvious or known to both parties."
        ),

        GrammarMaterial(
            courseTitle: "Honorifics & Politeness", // Diselaraskan
            topicTitle: "-(으)시- (-eu/si-) - Honorific Suffix",
            explanation: """
            This is an honorific suffix added to verb/adjective stems to show respect to the subject of the sentence.
            -으시- is used after a stem ending in a consonant.
            -시- is used after a stem ending in a vowel or 'ㄹ' (rieul).
            """,
            examples: [
                ExampleSentence(japanese: "선생님께서 오십니다.", romaji: "Seonsaengnim-kkeso osimnida.", english: "The teacher is coming. (Respectful)"),
                ExampleSentence(japanese: "아버지가 주무세요.", romaji: "Abeoji-ga jumuseyo.", english: "Father is sleeping. (Respectful)"),
                ExampleSentence(japanese: "어머니께서 읽으십니다.", romaji: "Eomeoni-kkeso ilgeusimnida.", english: "Mother is reading. (Respectful)")
            ],
            tip: "Used when the subject of the verb is older or of higher status."
        ),
        GrammarMaterial(
            courseTitle: "Honorifics & Politeness", // Diselaraskan
            topicTitle: "-(으)세요 (-eu/seyo) - Polite Request/Suggestion",
            explanation: """
            This is a commonly used polite ending for requests or suggestions, or to show deference.
            -으세요 is used after a verb stem ending in a consonant.
            -세요 is used after a verb stem ending in a vowel or 'ㄹ' (rieul).
            """,
            examples: [
                ExampleSentence(japanese: "앉으세요.", romaji: "Anjeuseyo.", english: "Please sit down."),
                ExampleSentence(japanese: "드세요.", romaji: "Deuseyo.", english: "Please eat. (Honorific of 먹다)"),
                ExampleSentence(japanese: "여기 계세요.", romaji: "Yeogi gyeseyo.", english: "Please stay here. (Honorific of 있다)")
            ],
            tip: "A very common and useful polite ending for daily interactions."
        ),
        GrammarMaterial(
            courseTitle: "Honorifics & Politeness", // Diselaraskan
            topicTitle: "Formal vs. Informal Speech Levels",
            explanation: """
            Korean has various speech levels that depend on the relationship between the speaker and the listener, and the formality of the situation.
            Formal polite (합니다-style): Used in public, news, military. Ends in -ㅂ니다/습니다.
            Informal polite (해요-style): Most common in daily life. Ends in -아요/어요.
            Informal casual (반말 - banmal): Used with close friends or younger people.
            """,
            examples: [
                ExampleSentence(japanese: "저는 학생입니다.", romaji: "Jeo-neun haksaeng-imnida.", english: "I am a student. (Formal polite)"),
                ExampleSentence(japanese: "저는 학생이에요.", romaji: "Jeo-neun haksaeng-ieyo.", english: "I am a student. (Informal polite)"),
                ExampleSentence(japanese: "난 학생이야.", romaji: "Nan haksaeng-iya.", english: "I'm a student. (Informal casual)")
            ],
            tip: "Mastering speech levels is key to natural Korean communication."
        ),


        // MARK: - Expert Grammar Materials
        GrammarMaterial(
            courseTitle: "Complex Sentence Structures", // Diselaraskan
            topicTitle: "-는지 / -(으)ㄴ지 / -ㄹ지 (Whether/If)",
            explanation: """
            This ending is used to express uncertainty or to ask about something that is unknown, functioning similarly to 'whether' or 'if' in English. It's often used with verbs of knowing, wondering, or asking.
            -는지 is used for verbs (present tense) and adjectives (present tense).
            -(으)ㄴ지 is used for adjectives (past tense) or verb (past tense).
            -ㄹ지 is used for future tense or supposition.
            """,
            examples: [
                ExampleSentence(japanese: "이게 맞는지 모르겠어요.", romaji: "Ige manneunji moreugesseoyo.", english: "I don't know if this is right."),
                ExampleSentence(japanese: "그가 왔는지 확인해 보세요.", romaji: "Geu-ga wannneunji hwaginhae boseyo.", english: "Please check if he came."),
                ExampleSentence(japanese: "어디로 갈지 결정했어요.", romaji: "Eodiro galji gyeoljeonghaesseoyo.", english: "I decided where to go.")
            ],
            tip: "Think of it as embedding a question or an unknown fact within a sentence."
        ),
        GrammarMaterial(
            courseTitle: "Complex Sentence Structures", // Diselaraskan
            topicTitle: "-(으)면서 (-eu/myeonseo) - While / At the same time",
            explanation: """
            This ending connects two actions or states that occur simultaneously or concurrently. The subject of both clauses must be the same.
            -으면서 is used after a verb stem ending in a consonant.
            -면서 is used after a verb stem ending in a vowel.
            """,
            examples: [
                ExampleSentence(japanese: "밥을 먹으면서 티비를 봐요.", romaji: "Bap-eul meogeumyeonseo tibi-reul bwayo.", english: "I watch TV while eating."),
                ExampleSentence(japanese: "노래를 들으면서 공부해요.", romaji: "Norae-reul deureumyeonseo gongbuhaeyo.", english: "I study while listening to music."),
                ExampleSentence(japanese: "웃으면서 이야기했어요.", romaji: "Useumyeonseo iyagihaesseoyo.", english: "I talked while smiling.")
            ],
            tip: "Useful for describing multitasking or parallel actions."
        ),
        GrammarMaterial(
            courseTitle: "Complex Sentence Structures", // Diselaraskan
            topicTitle: "-(으)ㄹ 줄 알다/모르다 (To know/not know how to / To expect/not expect)",
            explanation: """
            This pattern means 'to know how to do something' or 'to not know how to do something'. It can also mean 'to expect' or 'to not expect' something to happen.
            -(으)ㄹ 줄 알다/모르다 attaches to a verb stem.
            """,
            examples: [
                ExampleSentence(japanese: "한국말 할 줄 알아요?", romaji: "Hangukmal hal jul arayo?", english: "Do you know how to speak Korean?"),
                ExampleSentence(japanese: "운전할 줄 몰라요.", romaji: "Unjeonhal jul mollayo.", english: "I don't know how to drive."),
                ExampleSentence(japanese: "그가 올 줄 알았어요.", romaji: "Geu-ga ol jul arasseoyo.", english: "I thought he would come. (I expected him to come.)")
            ],
            tip: "Context determines 'how to' vs. 'expect'."
        ),

        GrammarMaterial(
            courseTitle: "Passive & Causative Forms", // Diselaraskan
            topicTitle: "Passive Voice: -이/히/리/기- (i/hi/ri/gi)",
            explanation: """
            Korean passive voice is formed by attaching specific suffixes (-이-, -히-, -리-, -기-) to a verb stem. This indicates that the subject is receiving the action.
            Example: 먹다 (to eat) -> 먹히다 (to be eaten)
            """,
            examples: [
                ExampleSentence(japanese: "문이 닫혔어요.", romaji: "Mun-i dachyeosseoyo.", english: "The door was closed."),
                ExampleSentence(japanese: "경찰에게 잡혔어요.", romaji: "Gyeongchal-ege japyeosseoyo.", english: "I was caught by the police."),
                ExampleSentence(japanese: "책이 읽혔어요.", romaji: "Chaeg-i ilkyeosseoyo.", english: "The book was read (by someone).")
            ],
            tip: "The subject 'suffers' or 'undergoes' the action."
        ),
        GrammarMaterial(
            courseTitle: "Passive & Causative Forms", // Diselaraskan
            topicTitle: "Causative Form: -이/히/리/기/우/추/구- (i/hi/ri/gi/u/chu/gu) and -(게) 하다",
            explanation: """
            The causative form is used to express that someone makes, lets, or has someone else do something. It can be formed with specific suffixes or with -(게) 하다.
            Example: 만들다 (to make) -> 만들게 하다 (to make someone make)
            """,
            examples: [
                ExampleSentence(japanese: "아이에게 밥을 먹였어요.", romaji: "Ai-ege bap-eul meogyeosseoyo.", english: "I fed the child (made the child eat)."),
                ExampleSentence(japanese: "선생님이 학생들에게 책을 읽게 했어요.", romaji: "Seonsaengnim-i haksaengdeul-ege chaeg-eul ilkge haesseoyo.", english: "The teacher made the students read a book."),
                ExampleSentence(japanese: "옷을 입혔어요.", romaji: "Os-eul iphyeosseoyo.", english: "I dressed someone (made someone wear clothes).")
            ],
            tip: "Distinguish between 'doing' and 'making someone do'."
        ),
        GrammarMaterial(
            courseTitle: "Passive & Causative Forms", // Diselaraskan
            topicTitle: "Transitive vs. Intransitive Verbs",
            explanation: """
            Transitive verbs take a direct object (e.g., 'eat bread'). Intransitive verbs do not take a direct object (e.g., 'sleep'). Understanding this helps in correctly using particles and passive/causative forms.
            """,
            examples: [
                ExampleSentence(japanese: "문을 열다 (transitive)", romaji: "mun-eul yeolda", english: "to open the door"),
                ExampleSentence(japanese: "문이 열리다 (intransitive)", romaji: "mun-i yeollida", english: "the door opens / to be opened"),
                ExampleSentence(japanese: "옷을 입다 (transitive)", romaji: "os-eul ipda", english: "to wear clothes"),
                ExampleSentence(japanese: "옷이 입혀지다 (intransitive)", romaji: "os-i iphyeojida", english: "clothes are worn / to be dressed")
            ],
            tip: "Many Korean verbs have related transitive/intransitive pairs."
        ),

        GrammarMaterial(
            courseTitle: "Indirect Quotations", // Diselaraskan
            topicTitle: "-(ㄴ/는)다고 하다 (Statement)",
            explanation: """
            Used to report someone else's statement.
            Verb stems ending in vowel/ㄹ + -ㄴ다고 하다
            Verb stems ending in consonant + -는다고 하다
            Adjectives/이다 + -(이)라고 하다
            """,
            examples: [
                ExampleSentence(japanese: "그는 학생이라고 했어요.", romaji: "Geu-neun haksaeng-irago haesseoyo.", english: "He said he was a student."),
                ExampleSentence(japanese: "비가 온다고 해요.", romaji: "Bi-ga ondago haeyo.", english: "They say it's raining."),
                ExampleSentence(japanese: "그는 예쁘다고 했어요.", romaji: "Geu-neun yeppeudago haesseoyo.", english: "He said it was pretty.")
            ],
            tip: "The most common form for reporting statements."
        ),
        GrammarMaterial(
            courseTitle: "Indirect Quotations", // Diselaraskan
            topicTitle: "-(으)라고 하다 (Command/Request)",
            explanation: """
            Used to report someone else's command or request.
            Verb stems ending in consonant + -으라고 하다
            Verb stems ending in vowel/ㄹ + -라고 하다
            """,
            examples: [
                ExampleSentence(japanese: "빨리 오라고 했어요.", romaji: "Ppalli orago haesseoyo.", english: "He told me to come quickly."),
                ExampleSentence(japanese: "책을 읽으라고 했어요.", romaji: "Chaeg-eul ilgeurago haesseoyo.", english: "He told me to read the book."),
                ExampleSentence(japanese: "여기에 앉으라고 하셨어요.", romaji: "Yeogi-e anjeurago hasyeosseoyo.", english: "He told me to sit here. (Honorific)")
            ],
            tip: "Often used when giving instructions or repeating orders."
        ),
        GrammarMaterial(
            courseTitle: "Indirect Quotations", // Diselaraskan
            topicTitle: "-(자고) 하다 (Suggestion)",
            explanation: """
            Used to report someone else's suggestion ('let's do X').
            Attached to verb stems: -자고 하다
            """,
            examples: [
                ExampleSentence(japanese: "같이 가자고 했어요.", romaji: "Gat-i gajago haesseoyo.", english: "He suggested we go together."),
                ExampleSentence(japanese: "밥 먹자고 했어요.", romaji: "Bap meokjago haesseoyo.", english: "She suggested we eat.")
            ],
            tip: "Simple form for 'let's...'"
        )
    ]

    // Fungsi statis untuk mendapatkan materi grammar berdasarkan judul kursus.
    // Nama fungsi ini adalah 'materials', bukan 'getMaterialsForCourse'.
    static func materials(forCourseTitle title: String) -> [GrammarMaterial] {
        // Filter array allMaterials berdasarkan courseTitle.
        // Ini mengasumsikan bahwa properti 'courseTitle' di dalam setiap GrammarMaterial
        // akan cocok dengan 'title' dari objek KoreanCourse yang dipilih.
        return allMaterials.filter { $0.courseTitle == title }
    }

    // Fungsi baru untuk mendapatkan materi grammar berdasarkan ID topik
    static func material(forId id: UUID) -> GrammarMaterial? {
        return allMaterials.first { $0.id == id }
    }
}
