# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Picture.delete_all
Picture.reset_pk_sequence
Picture.create([

               {name: 'Vogue may 2020', file: 'vogue052020.jfif', theme_id: 2},
               {name: 'Vogue june 2020', file: 'images(1).jfif', theme_id: 2},
               {name: 'Vogue july 2020', file: 'images(2).jfif', theme_id: 2},
               {name: 'Tatler feb 2021', file: 'Без названия.jfif', theme_id: 3},
               {name: 'Marie Claire', file: 'Без названия(1).jfif', theme_id: 3},
               {name: 'Street style feb', file: 'Без названия(2).jfif', theme_id: 4},
               {name: 'Street sryle march', file: 'Без названия(3).jfif', theme_id: 4},
             ])
Theme.delete_all
Theme.reset_pk_sequence
Theme.create([

               {name: "-----"},      # 1 Нет темы
               {name: "Какая из обложек журнала Vogue наиболее точно отражает состояние моды?"},      # 2
               {name: "Какой журнал наиболеее сильно воздействует на читателей?"},      # 3
               {name: "Какой образ отражает влияние локдауна на уличную моду?"},      # 4
             ])
User.delete_all
User.reset_pk_sequence
User.create([

              {name: "Kseniia Miakinkaia", email: "kseniia@railstutorial.org"},
            ])

